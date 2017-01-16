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
            $('#power_date').val(new Date().toDateInputValue());

            $("#btn_temperature_chart").on('click', function () {
                //clear canvas
                $('#TemperatureChart').remove(); // this is my <canvas> element
                $('#TemperatureChartHolder').append('<canvas id="TemperatureChart"><canvas>');

                //get vars
                var date = $("#temp_date").val();
                var devicename = $("#MainContent_DeviceNameLabel").text();
                var local = new Date();
                var timzoneoffset = local.getTimezoneOffset();
                var jsonData = JSON.stringify({
                    date: date,
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
                    var aData = reponse.d;
                    var aLabels = aData[0];
                    var aDatasets1 = aData[1];

                    var ctx = $("#TemperatureChart").get(0).getContext('2d');
                    ctx.canvas.height = 300;  // setting height of canvas
                    ctx.canvas.width = 500; // setting width of canvas
                    var fillPatternTemp = ctx.createLinearGradient(0, 0, 0.5, 205); //set the last number to calibrate the colour
                    fillPatternTemp.addColorStop(0, "rgba(239, 0, 0, 0.25)");
                    fillPatternTemp.addColorStop(0.5, "rgba(249, 170, 117, 0.25)");
                    fillPatternTemp.addColorStop(1, "rgba(150, 177, 247, 0.25)");
                    var borderPatternTemp = ctx.createLinearGradient(0, 0, 0.5, 205); //set the last number to calibrate the colour
                    borderPatternTemp.addColorStop(0, "rgba(239, 0, 0, 1)");
                    borderPatternTemp.addColorStop(0.5, "rgba(249, 170, 117, 1)");
                    borderPatternTemp.addColorStop(1, "rgba(150, 177, 247, 1)");

                    var data = {
                        labels: aLabels,
                        datasets: [{
                            label: "Temperature (°C)",
                            lineTension: 0.3,
                            backgroundColor: "rgba(255, 106, 0, 0.4)",
                            borderColor: "rgb(255, 106, 0)",
                            borderCapStyle: 'butt',
                            borderDash: [],
                            borderDashOffset: 0.0,
                            borderJoinStyle: 'miter',
                            pointBorderColor: "#3A3A3A",
                            pointBackgroundColor: "rgb(255, 106, 0)",
                            pointBorderWidth: 1,
                            pointHoverRadius: 5,
                            pointHoverBackgroundColor: "rgb(255, 106, 0)",
                            pointHoverBorderColor: "rgb(255, 106, 0)",
                            pointHoverBorderWidth: 2,
                            pointRadius: 1,
                            pointHitRadius: 10,
                            data: aDatasets1
                        }]
                    };

                    var lineChart = new Chart(ctx, { //TODO prevent multiple charts from overlapping
                        type: 'line',
                        data: data,
                        options: {
                            responsive: true,
                            scales: {
                                xAxes: [{
                                    ticks: {
                                        callback: function (tick) {
                                            var time = new Date(tick);
                                            var hour = time.getHours();
                                            var minutes = time.getMinutes();
                                            var ampm = "AM";
                                            if (minutes < 15) {
                                                minutes = "00";
                                            } else if (minutes < 45) {
                                                minutes = "30";
                                            } else {
                                                minutes = "00";
                                                ++hour;
                                            }
                                            if (hour > 23) {
                                                hour = 12;
                                            } else if (hour > 12) {
                                                hour = hour - 12;
                                                ampm = "PM";
                                            } else if (hour == 12) {
                                                ampm = "PM";
                                            } else if (hour == 0) {
                                                hour = 12;
                                            }
                                            else
                                            {

                                            }

                                            var newtick = (hour + ":" + minutes + " " + ampm);

                                            return newtick;
                                        }
                                            }
                                        }]
                                }
                        }
                    });
                }
                function OnErrorCall_(repo) {
                    alert("Woops something went wrong, please try later !");
                }
            });
                        
            $("#btn_power_chart").on('click', function () {
                //clear canvas
                $('#PowerChart').remove(); // this is my <canvas> element
                $('#PowerChartHolder').append('<canvas id="PowerChart"><canvas>');

                    var date = $("#power_date").val();
                    var devicename = $("#MainContent_DeviceNameLabel").text();
                    var local = new Date();
                    var timzoneoffset = local.getTimezoneOffset();
                    var jsonData = JSON.stringify({
                        date: date,
                        devicename: devicename,
                        timzoneoffset: timzoneoffset
                    });

                    $.ajax({
                        type: "POST",
                        url: "../DeviceService.asmx/fillPowerChart",
                        data: jsonData,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess_,
                        error: OnErrorCall_
                    });

                    function OnSuccess_(reponse) {
                        var aData = reponse.d;
                        var aLabels = aData[0];
                        var aDatasets1 = aData[1];

                        var ctx = $("#PowerChart").get(0).getContext('2d');
                        ctx.canvas.height = 300;  // setting height of canvas
                        ctx.canvas.width = 500; // setting width of canvas
                        var fillPatternPower = ctx.createLinearGradient(0, 0, 0.5, 175);
                        fillPatternPower.addColorStop(1, "rgba(193, 193, 193, 0.3)");
                        fillPatternPower.addColorStop(0.25, "rgba(255, 222, 10,0.5)");
                        var borderPatternPower = ctx.createLinearGradient(0, 0, 0.5, 175);
                        borderPatternPower.addColorStop(1, "rgb(193, 193, 193)");
                        borderPatternPower.addColorStop(0.25, "rgb(255, 222, 10)");

                        var data = {
                            labels: aLabels,
                            datasets: [{
                                label: "Power (W)",
                                lineTension: 0.3,
                                backgroundColor: "rgba(255, 106, 0, 0.4)",
                                borderColor: "rgb(255, 106, 0)",
                                borderCapStyle: 'butt',
                                borderDash: [],
                                borderDashOffset: 0.0,
                                borderJoinStyle: 'miter',
                                pointBorderColor: "#3A3A3A",
                                pointBackgroundColor: "rgba(249, 170, 117, 0.25)",
                                pointBorderWidth: 1,
                                pointHoverRadius: 5,
                                pointHoverBackgroundColor: "rgb(255, 106, 0)",
                                pointHoverBorderColor: "rgb(255, 106, 0)",
                                pointHoverBorderWidth: 2,
                                pointRadius: 1,
                                pointHitRadius: 10,
                                data: aDatasets1
                            }]
                        };

                        var lineChart = new Chart(ctx, {
                            type: 'line',
                            data: data,
                            options: {
                                responsive: true,
                                scales: {
                                    xAxes: [{
                                        ticks: {
                                            autoSkip: true,
                                            autoSkipPadding:10,
                                            callback: function (tick) {
                                                var time = new Date(tick);
                                                var hour = time.getHours();
                                                var minutes = time.getMinutes();
                                                var ampm = "AM";
                                                if (minutes < 15) {
                                                    minutes = "00";
                                                } else if (minutes < 45) {
                                                    minutes = "30";
                                                } else {
                                                    minutes = "00";
                                                    ++hour;
                                                }
                                                if (hour > 23) {
                                                    hour = 12;
                                                } else if (hour > 12) {
                                                    hour = hour - 12;
                                                    ampm = "PM";
                                                } else if (hour == 12) {
                                                    ampm = "PM";
                                                } else if (hour == 0) {
                                                    hour = 12;
                                                }
                                                else {

                                                }

                                                var newtick = (hour + ":" + minutes + " " + ampm);

                                                return newtick;
                                            }
                                        }
                                    }]
                                }
                            }
                        });
                    }
                    function OnErrorCall_(repo) {
                        alert("Woops something went wrong, please try later !");
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
                    <asp:Label ID="DeviceNameLabel" CssClass="h2" runat="server" Text="Device Name"></asp:Label>
                    <asp:Label ID="LastUpdatedTime" CssClass="text-muted" runat="server" Text="Panel not refreshed yet."></asp:Label>
                    <br />
                    <br />                   
                        <div class="col-md-2">
                            <asp:UpdatePanel runat="server" ID="DeviceStatePanel">
                                <ContentTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Status</h4>                      
                                        </div>
                                        <div class="panel-body top-divider">
                                            <div class="btn-group">
                                                <button class="btn btn-lg btn-default btn-label disabled">Power</button>
                                                <asp:Button ID="OnChangeControllerStateButton" CssClass="btn btn-lg" runat="server" Text="On" OnClick="ChangeControllerStateOn_Click" />
                                                <asp:Button ID="OffChangeControllerStateButton" CssClass="btn btn-lg" runat="server" Text="Off" OnClick="ChangeControllerStateOff_Click" />        
                                            </div>
                                            <br />
                                            <asp:Label ID="ChangeControllerStateLabel" CssClass="hybernate-fonts-secondary text-muted" Visible="false" runat="server" Text=" DeviceName will turn on/off soon"></asp:Label>
                                        </div>
                                    </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="OnChangeControllerStateButton" />
                                <asp:AsyncPostBackTrigger ControlID="OnChangeControllerStateButton" />                          
                        </Triggers>
                    </asp:UpdatePanel>    
                        </div>
                     <div class="row ">
                        <div class="col-md-3">
                            <asp:UpdatePanel runat="server" ID="NewSchedulePanel">
                                <ContentTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Schedule</h4>
                                        </div>
                                        <div class="panel-body top-divider">
                                              <div class="row">
                                                <div class="col-xs-10">
                                                </div>
                                                <div class="col-xs-1">
                                                  <asp:Button ID="ChangeScheduleButton" CssClass="btn btn-xs" runat="server" Text="⚙" OnClick="ChangeScheduleButton_Click" />
                                                </div>
                                              </div>                                            
                                            <div runat="server" id="newSchedule" visible="false" class="row">
                                                <div class="col-md-5">
                                                    <h5>Set new off time at:</h5>
                                                    <div class="input-group input-group-sm">
                                                        <span class="input-group-addon">🕘</span>
                                                        <asp:TextBox ID="newofftime" CssClass="form-control" runat="server" type="time"></asp:TextBox>
                                                    </div>
                                                </div>                                        
                                                <div class="col-md-1">
                                                    <br />
                                                </div>
                                                <div class="col-md-5">
                                                    <h5>Set new on time at:</h5>
                                                    <div class="input-group input-group-sm">
                                                        <span class="input-group-addon">🕔</span>
                                                        <asp:TextBox ID="newontime" CssClass="form-control" runat="server" type="time"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div runat="server" id="staticSchedule" class="row">
                                                <div class="col-md-4">
                                                    <h5>OFF</h5>
                                                    <asp:Label ID="OffTime" CssClass="hybernate-fonts-main" runat="server" Text="OffTime"></asp:Label>
                                                </div>                                        
                                                <div class="col-md-2">
                                                    <br />
                                                    <span class="hybernate-fonts-main">&#8594; </span>
                                                </div>
                                                <div class="col-md-5">
                                                    <h5>ON</h5>
                                                    <asp:Label ID="OnTime" CssClass="hybernate-fonts-main" runat="server" Text="OnTime"></asp:Label>
                                                </div>
                                            </div>
                                            <br />
                                            <asp:Button ID="SetNewScheduleButton" Visible="false" CssClass="btn btn-on" runat="server" Text="Set" OnClick="SetNewScheduleButton_Click" />
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ChangeScheduleButton" />                        
                            </Triggers>
                    </asp:UpdatePanel> 
                        </div>
                        <div class="col-md-3">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4>Temperature Statistics</h4>
                                </div>
                                <div id="TemperatureChartHolder" class="panel-body top-divider"">
                                    <asp:Label ID="CurrentTemperatureLabel" CssClass="hybernate-fonts-secondary" runat="server" Text="Current Temperature:"></asp:Label>
                                    <asp:Label ID="CurrentTemperature" CssClass="hybernate-fonts-secondary" runat="server" Text="28&#8451;"></asp:Label>
                                    <hr />
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon glyphicon glyphicon-calendar"></span>
                                        <input class="form-control" id="temp_date" type="date"/>
                                        <input id="btn_temperature_chart" type="button" class="form-control" value="Show Graph" />
                                    </div>
                                    <canvas id="TemperatureChart" width="0" height="0"> 
                                    </canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4>Power Statistics</h4>
                                </div>
                                <div id="PowerChartHolder" class="panel-body top-divider"">
                                    <asp:Label ID="CurrentPowerLabel" CssClass="hybernate-fonts-secondary" runat="server" Text="Current Power Usage:"></asp:Label>
                                    <asp:Label ID="CurrentPower" CssClass="hybernate-fonts-secondary" runat="server" Text="9001 W"></asp:Label>
                                    <hr />
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-addon glyphicon glyphicon-calendar"></span>
                                        <input class="form-control" id="power_date" type="date"/>
                                        <input id="btn_power_chart" type="button" class="form-control" value="Show Graph" />
                                    </div>
                                    <canvas id="PowerChart" width="0" height="0"> 
                                    </canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
            </asp:View>
            <asp:View ID="NewDeviceView" runat="server">
                <div class="container">
                    <div class="jumbotron">
                        <h3>Add New Device</h3>
                        <h5>Device UID:</h5>
                        <asp:TextBox ID="UIDTextbox" CssClass="form-control" runat="server" OnTextChanged="UIDTextbox_TextChanged"></asp:TextBox>
                        <h5>Device Name:</h5>
                        <asp:TextBox ID="NameTextbox" CssClass="form-control" runat="server" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                        <asp:Button ID="AddNewDeviceButton" CssClass="btn btn-primary btn-xs" runat="server" Text="Add" OnClick="AddNewDeviceButton_Click" />
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
    <br />
</asp:Content>
