<%@ Page Language="VB" MasterPageFile="~/Site.master" %>

<asp:Content ID="T" ContentPlaceHolderID="TitleContent" runat="server">Official Merch</asp:Content>

<asp:Content ID="M" ContentPlaceHolderID="MainContent" runat="server">

<!-- HERO -->
<section class="hero">
    <div class="hero-bg"></div>
    <img src="images/logo.png" alt="" class="hero-ghost" aria-hidden="true" />
    <div class="hero-inner">
        <p class="eyebrow reveal">New Merch Release</p>
        <h1 class="hero-title reveal">
            <span>Street</span><span class="outline">Drop</span>
        </h1>
        <p class="hero-sub reveal">Official Daily Hodge Podge gear. Blackout hoodies, premium caps and the Brappp Top. Limited runs, made to be worn daily.</p>
        <div class="hero-cta reveal">
            <a class="btn btn-solid" href="Shop.aspx">Shop the Drop</a>
            <a class="btn btn-ghost" href="About.aspx">Our Story</a>
        </div>
    </div>
    <div class="hero-product reveal">
        <img src="<%= Catalog.All(0).Image %>" alt="<%= Server.HtmlEncode(Catalog.All(0).Name) %> front and back" />
        <div class="hero-tag">
            <span><%= Server.HtmlEncode(Catalog.All(0).Drop) %></span>
            <strong><%= Server.HtmlEncode(Catalog.All(0).Name) %></strong>
        </div>
    </div>
</section>

<!-- MARQUEE -->
<div class="marquee" aria-hidden="true">
    <div class="marquee-track">
        <% For i As Integer = 0 To 1 %>
            <span>DAILY HODGE PODGE</span><i>&#9679;</i>
            <span>STREET DROP</span><i>&#9679;</i>
            <span>PREMIUM DROP</span><i>&#9679;</i>
            <span>BRAPPP</span><i>&#9679;</i>
            <span>WEAR IT DAILY</span><i>&#9679;</i>
        <% Next %>
    </div>
</div>

<!-- FEATURED -->
<section class="section">
    <div class="section-head reveal">
        <p class="eyebrow">The Lineup</p>
        <h2>Current Drops</h2>
    </div>
    <div class="grid">
        <% For Each p As Product In Catalog.All %>
            <%= Ui.ProductCard(p) %>
        <% Next %>
    </div>
    <div class="center reveal">
        <a class="btn btn-solid" href="Shop.aspx">View All Merch</a>
    </div>
</section>

<!-- BRAND BLOCK -->
<section class="section brand-block">
    <div class="brand-block-inner">
        <div class="reveal">
            <p class="eyebrow">Wear the crest</p>
            <h2>One mark.<br />Every day.</h2>
            <p>The DHP crest is the heart of everything we make. Letters locked inside a circle, cut by a single bold slash. Simple, loud and instantly yours.</p>
            <a class="btn btn-ghost" href="About.aspx">Read the story</a>
        </div>
        <div class="brand-block-art reveal">
            <img src="images/logo.png" alt="Daily Hodge Podge crest" />
        </div>
    </div>
</section>

<!-- WORDMARK BANNER -->
<section class="banner">
    <img src="images/wordmark.png" alt="Daily Hodge Podge" class="reveal" />
    <p class="reveal">Content. Chaos. Community. Now on a hoodie near you.</p>
</section>

</asp:Content>
