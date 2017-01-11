<%@ Page Title="Devices" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="WebServer1.Devices" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        //set todays date
        Date.prototype.toDateInputValue = (function () {
            var local = new Date(this);
            local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
            return local.toJSON().slice(0, 10);
        });
        

        //btn for tmp chart
        $(document).ready(function () {
            //for input dates
            $('#temp_date').val(new Date().toDateInputValue());

            $("#btn_temperature_chart").on('click', function () {
                var tempdate = $("#temp_date").val();
                var devicename = $("#MainContent_DeviceNameLabel").text();
                var local = new Date();
                var timzoneoffset = local.getTimezoneOffset();
                var jsonData = JSON.stringify({
                    tempdate: tempdate,
                    devicename: devicename,
                    timzoneoffset: timzoneoffset
                });

                $.ajax({
                    type: "POST",
                    url: "../DeviceService.asmx/fillTemperatureChart",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess_,
                    error: OnErrorCall_
                });

                function OnSuccess_(reponse) {
                    //console.log(response.d); //debug
                    var aData = reponse.d;
                    var aLabels = aData[0];
                    var aDatasets1 = aData[1];

                    var data = {
                        labels: aLabels,
                        datasets: [{
                            label: "Temperature",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: aDatasets1
                        }]
                    };

                    var ctx = $("#TemperatureChart").get(0).getContext('2d');
                    ctx.canvas.height = 300;  // setting height of canvas
                    ctx.canvas.width = 500; // setting width of canvas
                    var lineChart = new Chart(ctx, {
                        type: 'line',
                        data: data,
                        options: {
                            responsive: false
                        }
                    });
                }
                function OnErrorCall_(repo) {
                    alert("Woops something went wrong, pls try later !");
                }
            });
        });
    </script>

    <div id="maincontent" class="container-fluid page-contentwrapper">
        <br />
        <asp:MultiView ID="MainMultiView" runat="server">
            <asp:View ID="DefaultView" runat="server">
                <div class="jumbotron">
                    <h3>Manage Your Devices</h3>
                    <ul class=" list-group hybernate-fonts-secondary">
                        <li class="list-group-item bottom-divider"><a href="/User/Devices/Add">&#10010; Add New Device</a></li>
                        <asp:ListView ID="DeviceList" runat="server" DataSourceID="ListOfUserDevices">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li class="list-group-item"><a href="/User/Devices/<%# Eval("DeviceName") %>">&#9900; <%# Eval("DeviceName") %></a></li>
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
                <div class="">
                    <asp:UpdatePanel runat="server" ID="TitlePanel">
                        <ContentTemplate>
                            <asp:Label ID="DeviceNameLabel" CssClass="h2" runat="server" Text="Device Name"></asp:Label>
                            <span class="h2">-</span>
                            <asp:Label ID="LastUpdatedTime" CssClass="text-muted" runat="server" Text="Panel not refreshed yet."></asp:Label>
                            <br />
                            <br />
                            <div class="row ">
                                <div class="col-md-3">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Schedule</h4>
                                        </div>
                                        <div class="panel-body top-divider">
                                            <asp:Label ID="OnTime" runat="server" Text="On Time"></asp:Label>
                                            <asp:Label ID="OffTime" runat="server" Text="Off Time"></asp:Label>
                                            <br />
                                            <asp:Button ID="ChangeScheduleButton" CssClass="btn btn-xs" runat="server" Text="Change" OnClick="ChangeScheduleButton_Click" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Your device is currently:</h4>
                                        </div>
                                        <div class="panel-body top-divider"">
                                            <div class="btn-group">
                                                <asp:Button ID="OnChangeControllerStateButton" CssClass="btn btn-lg btn-warning" runat="server" Text="On" OnClick="ChangeControllerState_Click" />
                                                <asp:Button ID="OffChangeControllerStateButton" CssClass="btn btn-lg btn-off" runat="server" Text="Off" OnClick="ChangeControllerState_Click" />
                                            </div>
                                            <asp:Label ID="ChangeControllerStateLabel" CssClass="hybernate-fonts-secondary text-muted" runat="server" Text=" DeviceName will turn off soon"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Temperature Statistics</h4>
                                        </div>
                                        <div class="panel-body top-divider"">
                                            <asp:Label ID="CurrentTemperatureLabel" CssClass="hybernate-fonts-secondary" runat="server" Text="Current Temperature:"></asp:Label>
                                            <asp:Label ID="CurrentTemperature" CssClass="hybernate-fonts-secondary" runat="server" Text="28&#8451;"></asp:Label>
                                            <input  id="temp_date" type="date"/>
                                            <input id="btn_temperature_chart" type="button" class="btn btn-xs" value="Show Graph" />
                                            <canvas id="TemperatureChart"> </canvas>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Power Statistics</h4>
                                        </div>
                                        <div class="panel-body top-divider"">
                                            <asp:Label ID="CurrentPowerLabel" CssClass="hybernate-fonts-secondary" runat="server" Text="Current Power Usage:"></asp:Label>
                                            <asp:Label ID="CurrentPower" CssClass="hybernate-fonts-secondary" runat="server" Text="9000 W"></asp:Label>
                                            <asp:Chart ID="PowerStatsChart" runat="server">
                                                <Series>
                                                    <asp:Series Name="Series1">
                                                    </asp:Series>
                                                </Series>
                                                <ChartAreas>
                                                    <asp:ChartArea Name="PowerStatsChartArea">
                                                    </asp:ChartArea>
                                                </ChartAreas>
                                            </asp:Chart>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="UpdateTimer" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <asp:Timer ID="UpdateTimer" runat="server" OnTick="UpdateTimer_Tick" Interval="300000"></asp:Timer>
            </asp:View>
            <asp:View ID="NewDeviceView" runat="server">
                <div class="jumbotron">
                    <h3>Add New Device</h3>
                    <h5>Device UID:</h5>
                    <asp:TextBox ID="UIDTextbox" CssClass="form-control" runat="server" OnTextChanged="UIDTextbox_TextChanged"></asp:TextBox>
                    <h5>Device Name:</h5>
                    <asp:TextBox ID="NameTextbox" CssClass="form-control" runat="server" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                    <asp:Button ID="AddNewDeviceButton" CssClass="btn btn-primary btn-xs" runat="server" Text="Add" OnClick="AddNewDeviceButton_Click" />
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
    <br />
</asp:Content>
