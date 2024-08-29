<%@ Page Title="Admin Portal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPortal.aspx.cs" Inherits="DriversSystem.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        .custom-btn
        {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            display: inline-block;
            text-align: center;
            text-decoration: none;
            margin: 10px;
            border-radius: 5px;
            white-space: normal; 
            word-wrap: break-word; 
        }

        .custom-btn:hover 
        {
            background-color: white;
            color: #28a745;
        }

        .custom-panel 
        {
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            padding: 30px;
            margin-top: 20px;
        }

        .panel-heading 
        {
            font-size: 26px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .row 
        {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; 
        }

        .col-md-6 
        {
            flex: 0 0 50%;
            max-width: 50%;
            padding: 15px;
        }

        @media (max-width: 768px) 
        {
            .col-md-6 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }

    </style>

    <div class="text-center my-5">

        <h1 class="mb-5" style="color: #28a745;">Admin Portal</h1>

        <div class="row mt-4">

            <div class="col-md-6">
                <h2 class="panel-heading">Maintain</h2>

                <div class="custom-panel">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Services" PostBackUrl="~/MantainServices.aspx" />
                    <asp:Button runat="server" CssClass="custom-btn" Text="Available Times" PostBackUrl="~/MantainAvailableTimes.aspx" />
                    <asp:Button runat="server" CssClass="custom-btn" Text="Applications" PostBackUrl="~/MantainApplications.aspx" />
                    <asp:Button runat="server" CssClass="custom-btn" Text="Cities" PostBackUrl="~/MaintainCities.aspx" />
                </div>

            </div>

            <div class="col-md-6">
                <h2 class="panel-heading">Reports</h2>
                <div class="custom-panel">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Number of Appointments Per Week Per Time Period" />
                    <asp:Button runat="server" CssClass="custom-btn" Text="Income Per Time Period" />
                </div>

            </div>

        </div>

    </div>

</asp:Content>
