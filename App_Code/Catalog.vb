Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Web
Imports System.Web.Script.Serialization

Public Class Product
    Public Property Id As String = ""
    Public Property Name As String = ""
    Public Property Drop As String = ""
    Public Property Tagline As String = ""
    Public Property Description As String = ""
    Public Property Price As Decimal
    Public Property Image As String = ""
    Public Property Sizes As String() = New String() {}
    Public Property Details As String() = New String() {}
    Public Property Badge As String = ""
End Class

''' <summary>
''' The merch catalogue. Edit names, prices, sizes and copy here and the whole
''' site updates. Prices are PLACEHOLDERS - change them before launch.
''' </summary>
Public Class Catalog

    ' Philippine peso sign (built from its code point so the file stays plain ASCII)
    Public Shared ReadOnly CurrencySymbol As String = ChrW(&H20B1).ToString()

    Public Shared ReadOnly All As List(Of Product) = BuildCatalog()

    Private Shared Function BuildCatalog() As List(Of Product)
        Dim list As New List(Of Product)()

        list.Add(New Product With {
            .Id = "street-drop-hoodie",
            .Name = "Street Drop Hoodie",
            .Drop = "Street Drop",
            .Tagline = "Small logo up front. Big statement on the back.",
            .Description = "The heavyweight blackout hoodie. A clean DHP crest over the heart and a full-size crest across the back. Built to be worn daily.",
            .Price = 999D,
            .Image = "images/hoodie.jpg",
            .Sizes = New String() {"S", "M", "L", "XL", "2XL"},
            .Details = New String() {"Heavyweight fleece", "Front chest + oversized back print", "Kangaroo pocket, ribbed cuffs", "Unisex fit"},
            .Badge = "New"
        })

        list.Add(New Product With {
            .Id = "premium-drop-hoodie",
            .Name = "Premium Drop Hoodie",
            .Drop = "Premium Drop",
            .Tagline = "The wordmark up front. The crest across the back.",
            .Description = "The Premium Drop hoodie. The yellow Daily Hodge Podge wordmark badge across the chest and the full-size DHP crest on the back, on a blackout heavyweight hoodie.",
            .Price = 1099D,
            .Image = "images/hoodie-premium.jpg",
            .Sizes = New String() {"S", "M", "L", "XL", "2XL"},
            .Details = New String() {"Heavyweight fleece", "Wordmark badge front + oversized crest back", "Kangaroo pocket, ribbed cuffs", "Unisex fit"},
            .Badge = "Premium"
        })

        list.Add(New Product With {
            .Id = "premium-trucker-cap",
            .Name = "Premium Trucker Cap",
            .Drop = "Premium Drop",
            .Tagline = "Black on black. Logo on lock.",
            .Description = "Structured trucker cap with a textured DHP crest on the front panel and a breathable mesh back.",
            .Price = 499D,
            .Image = "images/cap.jpg",
            .Sizes = New String() {"One Size"},
            .Details = New String() {"Structured front panel", "Breathable mesh back", "Curved brim", "Adjustable snapback"},
            .Badge = "Premium"
        })

        list.Add(New Product With {
            .Id = "brappp-top-v2",
            .Name = "Brappp Top V2",
            .Drop = "Street Drop",
            .Tagline = "Sleeveless. Washed black. Ready to rev.",
            .Description = "The second run of the Brappp Top: a washed black sleeveless cut with the DHP crest and Daily Hodge Podge wordmark on the chest.",
            .Price = 199D,
            .Image = "images/brappp-top.jpg",
            .Sizes = New String() {"S", "M", "L", "XL", "2XL"},
            .Details = New String() {"Washed black cotton", "Sleeveless muscle cut", "Chest crest print", "Unisex fit"},
            .Badge = "V2"
        })

        Return list
    End Function

    Public Shared Function Find(id As String) As Product
        If String.IsNullOrEmpty(id) Then Return Nothing
        Return All.FirstOrDefault(Function(p) p.Id = id)
    End Function

    Public Shared Function Drops() As IEnumerable(Of String)
        Return All.Select(Function(p) p.Drop).Distinct()
    End Function

End Class

''' <summary>Small helpers that render shared HTML for the pages.</summary>
Public Class Ui

    Public Shared Function Money(amount As Decimal) As String
        Return Catalog.CurrencySymbol & amount.ToString("N0")
    End Function

    Public Shared Function ProductCard(p As Product) As String
        Dim url As String = "Product.aspx?id=" & HttpUtility.UrlEncode(p.Id)
        Dim sb As New StringBuilder()

        sb.Append("<article class=""card reveal"">")
        sb.Append("<a class=""card-media"" href=""" & url & """>")
        sb.Append("<img src=""" & HttpUtility.HtmlAttributeEncode(p.Image) & """ alt=""" & HttpUtility.HtmlAttributeEncode(p.Name) & """ loading=""lazy"" />")
        If Not String.IsNullOrEmpty(p.Badge) Then
            sb.Append("<span class=""badge"">" & HttpUtility.HtmlEncode(p.Badge) & "</span>")
        End If
        sb.Append("</a>")
        sb.Append("<div class=""card-body"">")
        sb.Append("<p class=""card-drop"">" & HttpUtility.HtmlEncode(p.Drop) & "</p>")
        sb.Append("<h3><a href=""" & url & """>" & HttpUtility.HtmlEncode(p.Name) & "</a></h3>")
        sb.Append("<p class=""card-tag"">" & HttpUtility.HtmlEncode(p.Tagline) & "</p>")
        sb.Append("<div class=""card-foot"">")
        sb.Append("<strong class=""price"">" & HttpUtility.HtmlEncode(Money(p.Price)) & "</strong>")
        sb.Append("<button type=""button"" class=""btn btn-solid btn-sm"" data-quick-add=""" & HttpUtility.HtmlAttributeEncode(p.Id) &
                  """ data-sizes=""" & HttpUtility.HtmlAttributeEncode(String.Join(",", p.Sizes)) & """>Add to Cart</button>")
        sb.Append("</div></div></article>")

        Return sb.ToString()
    End Function

    ''' <summary>Product list as JSON for the cart script.</summary>
    Public Shared Function ProductsJson() As String
        Dim items = Catalog.All.Select(Function(p) New With {
            .id = p.Id, .name = p.Name, .price = p.Price, .image = p.Image
        }).ToList()
        Return New JavaScriptSerializer().Serialize(items)
    End Function

    Public Shared Function JsString(value As String) As String
        Return New JavaScriptSerializer().Serialize(value)
    End Function

End Class
