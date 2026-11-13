(function () {
    "use strict";

    const $ = (s, r = document) => r.querySelector(s);
    const $$ = (s, r = document) => [...r.querySelectorAll(s)];
    const money = n => DHP.currency + Number(n).toLocaleString("en-US");
    const KEY = "dhp_cart_v1";

    /* ---------- Header / nav ---------- */
    const header = $("#siteHeader");
    const onScroll = () => header.classList.toggle("scrolled", window.scrollY > 30);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });

    const nav = $("#nav");
    $("#burger").addEventListener("click", () => nav.classList.toggle("open"));
    $$("#nav a").forEach(a => a.addEventListener("click", () => nav.classList.remove("open")));

    /* ---------- Scroll reveal ---------- */
    const io = "IntersectionObserver" in window
        ? new IntersectionObserver(entries => {
            entries.forEach(e => {
                if (e.isIntersecting) { e.target.classList.add("in"); io.unobserve(e.target); }
            });
        }, { threshold: 0.12 })
        : null;
    $$(".reveal").forEach(el => io ? io.observe(el) : el.classList.add("in"));

    /* ---------- Toast ---------- */
    const toastEl = $("#toast");
    let toastTimer;
    function toast(msg) {
        toastEl.textContent = msg;
        toastEl.classList.add("show");
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => toastEl.classList.remove("show"), 2200);
    }

    /* ---------- Cart state ---------- */
    let cart = [];
    try { cart = JSON.parse(localStorage.getItem(KEY)) || []; } catch { cart = []; }
    const save = () => { try { localStorage.setItem(KEY, JSON.stringify(cart)); } catch { /* ignore */ } };
    const find = id => DHP.products.find(p => p.id === id);

    function add(id, size, qty) {
        const existing = cart.find(l => l.id === id && l.size === size);
        if (existing) existing.qty += qty; else cart.push({ id, size, qty });
        save(); render();
        const countEl = $("#cartCount");
        countEl.classList.remove("bump"); void countEl.offsetWidth; countEl.classList.add("bump");
        toast("Added to cart");
    }

    function render() {
        const body = $("#cartItems");
        body.innerHTML = "";
        let total = 0, count = 0;

        if (!cart.length) {
            body.innerHTML = '<p class="empty">Your cart is empty.<br>Go grab something.</p>';
        }

        cart.forEach((l, i) => {
            const p = find(l.id);
            if (!p) return;
            total += p.price * l.qty; count += l.qty;

            const row = document.createElement("div");
            row.className = "line";
            row.innerHTML =
                '<img alt="">' +
                '<div><h4></h4><small></small>' +
                '<span class="mini-qty"><button data-act="dec" aria-label="Less">&minus;</button><span></span><button data-act="inc" aria-label="More">+</button></span></div>' +
                '<div><strong></strong><button class="remove" data-act="rm">Remove</button></div>';
            // set text via textContent (no HTML injection)
            $("img", row).src = p.image;
            $("h4", row).textContent = p.name;
            $("small", row).textContent = "Size: " + l.size;
            $(".mini-qty > span", row).textContent = l.qty;
            $("strong", row).textContent = money(p.price * l.qty);
            row.addEventListener("click", e => {
                const act = e.target.dataset && e.target.dataset.act;
                if (!act) return;
                if (act === "inc") l.qty++;
                if (act === "dec") l.qty--;
                if (act === "rm") l.qty = 0;
                if (l.qty <= 0) cart.splice(i, 1);
                save(); render();
            });
            body.appendChild(row);
        });

        $("#cartCount").textContent = count;
        $("#cartTotal").textContent = money(total);
    }

    /* ---------- Drawer ---------- */
    const drawer = $("#drawer"), overlay = $("#overlay");
    function openCart() { drawer.classList.add("open"); overlay.classList.add("open"); drawer.setAttribute("aria-hidden", "false"); }
    function closeCart() { drawer.classList.remove("open"); overlay.classList.remove("open"); drawer.setAttribute("aria-hidden", "true"); }
    $("#openCart").addEventListener("click", openCart);
    $("#closeCart").addEventListener("click", closeCart);
    overlay.addEventListener("click", closeCart);
    document.addEventListener("keydown", e => { if (e.key === "Escape") closeCart(); });

    /* ---------- Checkout (order by email) ---------- */
    $("#checkoutBtn").addEventListener("click", e => {
        e.preventDefault();
        if (!cart.length) { toast("Cart is empty"); return; }
        let total = 0;
        const lines = cart.map(l => {
            const p = find(l.id); total += p.price * l.qty;
            return "- " + l.qty + " x " + p.name + " (" + l.size + ") " + money(p.price * l.qty);
        });
        const body = "Hi Daily Hodge Podge! I'd like to order:\n\n" + lines.join("\n") +
            "\n\nTotal: " + money(total) + "\n\nName:\nShipping address:\n";
        window.location.href = "mailto:" + DHP.orderEmail +
            "?subject=" + encodeURIComponent("Merch order") + "&body=" + encodeURIComponent(body);
    });

    /* ---------- Product cards: quick add ---------- */
    $$("[data-quick-add]").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.dataset.quickAdd;
            const sizes = (btn.dataset.sizes || "").split(",").filter(Boolean);
            if (sizes.length === 1) { add(id, sizes[0], 1); openCart(); }
            else { window.location.href = "Product.aspx?id=" + id; } // pick a size first
        });
    });

    /* ---------- Product page ---------- */
    const addBtn = $("#addToCart");
    if (addBtn) {
        let size = ($(".size.active") || {}).dataset?.size || null;
        $$(".size").forEach(b => b.addEventListener("click", () => {
            $$(".size").forEach(x => x.classList.remove("active"));
            b.classList.add("active"); size = b.dataset.size;
        }));
        const qtyInput = $("#qtyInput");
        $("#qtyMinus").addEventListener("click", () => qtyInput.value = Math.max(1, +qtyInput.value - 1));
        $("#qtyPlus").addEventListener("click", () => qtyInput.value = Math.min(10, +qtyInput.value + 1));
        addBtn.addEventListener("click", () => {
            if (!size) {
                const s = $("#sizes"); s.classList.remove("shake"); void s.offsetWidth; s.classList.add("shake");
                toast("Pick a size first");
                return;
            }
            add(addBtn.dataset.id, size, +qtyInput.value);
            openCart();
        });
    }

    /* ---------- Shop filters ---------- */
    $$("#filters .chip").forEach(chip => chip.addEventListener("click", () => {
        $$("#filters .chip").forEach(c => c.classList.remove("active"));
        chip.classList.add("active");
        const f = chip.dataset.filter;
        $$("#productGrid .grid-item").forEach(item => {
            item.classList.toggle("hide", f !== "all" && item.dataset.drop !== f);
        });
    }));

    render();
})();
