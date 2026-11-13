<%@ Page Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Contact.aspx.vb" Inherits="ContactPage" %>

<asp:Content ID="T" ContentPlaceHolderID="TitleContent" runat="server">Contact</asp:Content>

<asp:Content ID="M" ContentPlaceHolderID="MainContent" runat="server">

<section class="page-head">
    <p class="eyebrow">Get in touch</p>
    <h1>Contact</h1>
</section>

<section class="section tight">
    <div class="contact-wrap">

        <asp:Panel ID="pnlSent" runat="server" Visible="false" CssClass="notice">
            <h2>Message received.</h2>
            <p>Thanks, <asp:Literal ID="litName" runat="server" />. We'll get back to you soon.</p>
            <a class="btn btn-solid" href="Shop.aspx">Back to shop</a>
        </asp:Panel>

        <form id="frmContact" runat="server" class="form">
            <div class="field">
                <asp:Label ID="lblName" runat="server" AssociatedControlID="txtName" Text="Name" />
                <asp:TextBox ID="txtName" runat="server" MaxLength="80" autocomplete="name" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="err" Display="Dynamic" ErrorMessage="Please enter your name." />
            </div>
            <div class="field">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email" />
                <asp:TextBox ID="txtEmail" runat="server" MaxLength="120" TextMode="Email" autocomplete="email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="err" Display="Dynamic" ErrorMessage="Please enter your email." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" CssClass="err" Display="Dynamic"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="That email doesn't look right." />
            </div>
            <div class="field">
                <asp:Label ID="lblMessage" runat="server" AssociatedControlID="txtMessage" Text="Message" />
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" MaxLength="2000" placeholder="Order questions, sizing, collabs..." />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMessage" CssClass="err" Display="Dynamic" ErrorMessage="Please write a message." />
            </div>
            <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn btn-solid" />
        </form>

    </div>
</section>

</asp:Content>
