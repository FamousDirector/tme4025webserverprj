<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebServer1.Contact" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Contact Us</h1>
        <hr class="coloured-hr"/>
        <div class="form-horizontal">
            <asp:ValidationSummary runat="server" CssClass="text-danger" />
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Your Email:</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="The email field is required." />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Name" CssClass="col-md-2 control-label">Your Name:</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Name" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" 
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="We need to know your name!" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Subject" CssClass="col-md-2 control-label">Subject</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Subject" TextMode="SingleLine" CssClass="form-control" />                        
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Body" CssClass="col-md-2 control-label">Body</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Body" TextMode="MultiLine" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Label ID="CaptchaLabel" runat="server" AssociatedControlID="CaptchaCode">
                        Retype the characters from the picture:
                    </asp:Label>
                    <BotDetect:WebFormsCaptcha ID="CaptchaCode" runat="server" />
                    <asp:TextBox ID="CaptchaCodeTextBox" runat="server" />
                    <asp:Label ID="CaptchaErrorLabel" CssClass="text-danger" runat="server"/>
                </div>
            </div> 
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" OnClick="SendMail_Click" Text="Register" CssClass="btn btn-on" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
    
