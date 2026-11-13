# Daily Hodge Podge - Merch Site (VB.NET / ASP.NET Web Forms)

Black / yellow / white street-wear look built from your logo and drop posters.
Written in VB.NET as an ASP.NET Web Forms **Web Site** (.NET Framework 4.7.2).

## Run it in Visual Studio 2019
1. Unzip the folder.
2. Visual Studio: **File > Open > Web Site...** and choose the `DailyHodgePodgeVB` folder.
3. Press **Ctrl+F5**. (Choose IIS Express if asked.)

Needs the **ASP.NET and web development** workload (it includes .NET Framework 4.7.2).
If you have another .NET Framework version, change `4.7.2` in `Web.config` (two places).

## Things to edit
| What | Where |
|---|---|
| Products, prices, sizes, descriptions | `App_Code/Catalog.vb` (prices are placeholders) |
| Order email used by "Place Order" | `Site.master` (`orderEmail`) |
| Story / about copy | `About.aspx` |
| Colors and fonts | top of `css/site.css` (`:root`) |
| Images | `images/` |
| Contact messages | saved to `App_Data/messages.txt`; edit `Contact.aspx.vb` to email them instead |

The cart is stored in the visitor's browser; "Place Order" opens an email with the order filled in.
