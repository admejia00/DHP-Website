<%@ Page Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Product.aspx.vb" Inherits="ProductPage" %>

<asp:Content ID="T" ContentPlaceHolderID="TitleContent" runat="server"><%= Server.HtmlEncode(Item.Name) %></asp:Content>

<asp:Content ID="M" ContentPlaceHolderID="MainContent" runat="server">

<section class="pdp">
    <a class="back" href="Shop.aspx">&larr; Back to shop</a>
    <div class="pdp-grid">
        <div class="pdp-media reveal">
            <img src="<%= Item.Image %>" alt="<%= Server.HtmlEncode(Item.Name) %>" />
        </div>
        <div class="pdp-info reveal">
            <p class="card-drop"><%= Server.HtmlEncode(Item.Drop) %></p>
            <h1><%= Server.HtmlEncode(Item.Name) %></h1>
            <p class="pdp-price"><%= Ui.Money(Item.Price) %></p>
            <p class="lead"><%= Server.HtmlEncode(Item.Description) %></p>

            <div class="sizes" id="sizes">
                <span class="label">Size</span>
                <% For Each s As String In Item.Sizes %>
                    <button type="button" class="size<%= If(Item.Sizes.Length = 1, " active", "") %>" data-size="<%= Server.HtmlEncode(s) %>"><%= Server.HtmlEncode(s) %></button>
                <% Next %>
            </div>

            <div class="qty">
                <span class="label">Qty</span>
                <button type="button" id="qtyMinus" aria-label="Decrease">&minus;</button>
                <input id="qtyInput" value="1" readonly="readonly" />
                <button type="button" id="qtyPlus" aria-label="Increase">+</button>
            </div>

            <button type="button" class="btn btn-solid btn-block" id="addToCart" data-id="<%= Server.HtmlEncode(Item.Id) %>">Add to Cart</button>

            <ul class="details">
                <% For Each d As String In Item.Details %>
                    <li><%= Server.HtmlEncode(d) %></li>
                <% Next %>
            </ul>
        </div>
    </div>
</section>

<section class="section tight">
    <div class="section-head">
        <p class="eyebrow">Keep going</p>
        <h2>More from the drop</h2>
    </div>
    <div class="grid">
        <% For Each other As Product In Catalog.All %>
            <% If other.Id <> Item.Id Then %>
                <%= Ui.ProductCard(other) %>
            <% End If %>
        <% Next %>
    </div>
</section>

</asp:Content>
