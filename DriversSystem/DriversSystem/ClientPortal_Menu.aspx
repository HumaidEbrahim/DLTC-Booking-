<%@ Page Title="Client Menu" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ClientPortal_Menu.aspx.cs" Inherits="DriversSystem.ClientPortal_Menu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .custom-btn {
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
            white-space: normal; /* Allow text to wrap */
            word-wrap: break-word; /* Ensure long words break to the next line */
            width: 100%; /* Full width for buttons */
        }

        .custom-btn:hover {
            background-color: white;
            color: #28a745;
        }

        .custom-panel {
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            padding: 30px;
            margin-top: 20px;
            width: 100%;
            max-width: 500px; /* Limit max width */
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            min-height: 300px; /* Ensure equal height */
        }

        .panel-heading {
            font-size: 26px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .row {
            display: flex;
            justify-content: space-around; /* Center the panels and add space around them */
            align-items: center; /* Vertically align the panels */
            gap: 20px; /* Add some space between the columns */
            flex-wrap: wrap;
        }

        .col-md-6 {
            display: flex;
            justify-content: center; /* Center content horizontally */
            flex: 1;
        }

        .equal-height {
            display: flex;
            flex-direction: column;
            justify-content: center; /* Center buttons vertically */
            height: 100%;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
        }

        @media (max-width: 768px) {
            .custom-panel {
                max-width: 100%;
                margin-left: 20px;
                margin-right: 20px;
            }
        }
    </style>

    <div class="text-center my-5">
        <h1 class="mb-5" style="color: #28a745;">Client Portal Menu</h1>
        
        <h3 class="mb-4">Please select an option below:</h3>
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="custom-panel equal-height">
                    <h2 class="panel-heading">User Details</h2>
                    <div class="button-container">
                        <asp:Button runat="server" CssClass="custom-btn" Text="Edit User Details" PostBackUrl="~/ClientPortal_MaintainClients.aspx"/>
                        <asp:Button runat="server" CssClass="custom-btn" Text="Delete User Details" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="custom-panel equal-height">
                    <h2 class="panel-heading">Application</h2>
                    <div class="button-container">
                        <asp:Button runat="server" CssClass="custom-btn" Text="Create a New Application" PostBackUrl="~/ClientPortal_AddApplicationDetails.aspx"/>
                        <asp:Button runat="server" CssClass="custom-btn" Text="Edit User Application" />
                        <asp:Button runat="server" CssClass="custom-btn" Text="Delete User Application" />
                        <asp:Button runat="server" CssClass="custom-btn" Text="View Application" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

