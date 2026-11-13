Imports System.IO

Partial Class ContactPage
    Inherits System.Web.UI.Page

    Private Shared ReadOnly FileLock As New Object()

    Protected Sub btnSend_Click(sender As Object, e As EventArgs) Handles btnSend.Click
        If Not Page.IsValid Then Return

        Dim name As String = Clean(txtName.Text)
        Dim email As String = Clean(txtEmail.Text)
        Dim message As String = txtMessage.Text.Trim()

        ' Saves each message to App_Data\messages.txt.
        ' TODO: to receive them by email instead, send with System.Net.Mail.SmtpClient here.
        Dim entry As String =
            "----- " & DateTime.Now.ToString("yyyy-MM-dd HH:mm") & " -----" & vbCrLf &
            "Name:  " & name & vbCrLf &
            "Email: " & email & vbCrLf &
            message & vbCrLf & vbCrLf

        SyncLock FileLock
            File.AppendAllText(Server.MapPath("~/App_Data/messages.txt"), entry)
        End SyncLock

        litName.Text = Server.HtmlEncode(name)
        pnlSent.Visible = True
        frmContact.Visible = False
    End Sub

    ' Keep single-line fields on a single line
    Private Function Clean(value As String) As String
        Return value.Replace(vbCr, " ").Replace(vbLf, " ").Trim()
    End Function

End Class
