<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id ="maincontent" class="container page-contentwrapper">
        <asp:MultiView ID="MainMultiView" runat="server" >
            <asp:View ID="DefaultView" runat="server">
                <div class="jumbotron"> 
                    <h3>Manage Your Devices</h3>
                    <ul>
                        <li><a href="/User/Devices/Add">Add Device...</a></li>
                        <li><a href="/User/Devices/Remove">Remove Device...</a></li>
                        <asp:ListView ID="DeviceList" runat="server" DataSourceID="ListOfUserDevices">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />                                   
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li><a href="/User/Devices/<%# Eval("DeviceName") %>"><%# Eval("DeviceName") %></a></li>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="ListOfUserDevices" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource> 
                    </ul>
                </div>
            </asp:View>
            <asp:View ID="DeviceView" runat="server">
                <asp:UpdatePanel runat="server">
                </asp:UpdatePanel>                
            </asp:View>
            <asp:View ID="NewDeviceView" runat="server">
                <div class="jumbotron">                    
                    <h3>Add New Device</h3>
                    <h4>Device UID:</h4>
                    <asp:TextBox ID="UIDTextbox" CssClass="form-control" runat="server" OnTextChanged="UIDTextbox_TextChanged"></asp:TextBox>                    
                    <h4>Device Name:</h4>
                    <asp:TextBox ID="NameTextbox" CssClass="form-control" runat="server" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                    <asp:Button ID="AddNewDeviceButton" CssClass="btn btn-primary btn-small" runat="server" Text="Add" OnClick="AddNewDeviceButton_Click" />
                </div>
            </asp:View>
            <asp:View ID="RemoveDeviceView" runat="server">
                <div class="jumbotron">                    
                    <h3>Remove A Device</h3>
                   <ul>
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="ListOfUserDevices">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />                                   
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li>
                                    <asp:Button ID="RemoveDeviceButton" CssClass="btn btn-danger" runat="server"  Text='<%#Eval("DeviceName")%>'/>                
                                </li>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HybernateDatabaseConnectionString %>" SelectCommand="SELECT [DeviceName] FROM [UserDevices] WHERE ([UserName] = @UserName)">
                            <SelectParameters>
                                <asp:SessionParameter Name="UserName" SessionField="username" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource> 
                    </ul>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
