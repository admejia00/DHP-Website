<%@ Page Language="VB" MasterPageFile="~/Site.master" %>

<asp:Content ID="T" ContentPlaceHolderID="TitleContent" runat="server">Shop</asp:Content>

<asp:Content ID="M" ContentPlaceHolderID="MainContent" runat="server">

<section class="page-head">
    <p class="eyebrow">Official Merch</p>
    <h1>Shop</h1>
    <div class="filters" id="filters">
        <button type="button" class="chip active" data-filter="all">All</button>
        <% For Each d As String In Catalog.Drops() %>
            <button type="button" class="chip" data-filter="<%= Server.HtmlEncode(d) %>"><%= Server.HtmlEncode(d) %></button>
        <% Next %>
    </div>
</section>

<section class="section tight">
    <div class="grid" id="productGrid">
        <% For Each p As Product In Catalog.All %>
            <div class="grid-item" data-drop="<%= Server.HtmlEncode(p.Drop) %>">
                <%= Ui.ProductCard(p) %>
            </div>
        <% Next %>
    </div>
</section>

</asp:Content>
