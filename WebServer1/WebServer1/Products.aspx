<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WebServer1.Products" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2>Product Name</h2>
        <hr class="coloured-hr"/>
        <h4><em>"one liner"</em></h4>
        <h2>How It Works</h2>
        <hr class="coloured-hr"/>
        <p>Stuff</p>
        <h2>Customer Reviews</h2>
        <hr class="coloured-hr"/>
            <div class="panel panel-default">
                <div class="panel-body">
                    <asp:UpdatePanel runat="server" ID="CustomerReviewsPanel">
                        <ContentTemplate>
                            <asp:MultiView ID="CustomerReviewMultiView" runat="server" ActiveViewIndex="0">
                                <asp:View ID="CustomerReview1" runat="server">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <img src="" class="img-circle img-responsive"></img>
                                        </div>
                                        <div class="col-lg-7">
                                            <p><em>"Quote"</em></p>
                                            <br />
                                            <h5 class="text-right">- Person Name</h5>
                                        </div>
                                    </div>
                                </asp:View>
                                
                            </asp:MultiView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CustomerReviewUpdateTimer" />
                            <asp:AsyncPostBackTrigger ControlID="LastReivewButton" />
                            <asp:AsyncPostBackTrigger ControlID="NextReivewButton" />                            
                        </Triggers>
                    </asp:UpdatePanel> 
                </div>
            </div>  
            <asp:Button CssClass="pull-left btn btn-xs btn-off" ID="LastReivewButton" runat="server" OnClick="LastReivewButton_Click" Text="<" />
            <asp:Button  CssClass="pull-right btn btn-xs btn-off" ID="NextReivewButton" runat="server" OnClick="NextReivewButton_Click" Text=">" />
            <asp:Timer ID="CustomerReviewUpdateTimer" runat="server" OnTick="NextReivew_Tick" Interval="5000"></asp:Timer>
        <br />
        <h2>Resources</h2>
        <hr class="coloured-hr"/>
        <a>Link to manual (PDF)</a>                           
        </div>

</asp:Content>
