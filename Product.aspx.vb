Partial Class ProductPage
    Inherits System.Web.UI.Page

    ' The product being shown (used by Product.aspx markup)
    Protected Item As Product

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Item = Catalog.Find(Request.QueryString("id"))

        If Item Is Nothing Then
            ' Unknown product: send the visitor back to the shop
            Response.Redirect("~/Shop.aspx")
        End If
    End Sub

End Class
