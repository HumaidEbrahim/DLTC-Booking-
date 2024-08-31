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
            display: block; 
            text-align: center;
            text-decoration: none;
            margin: 10px 0; 
            border-radius: 5px;
            white-space: normal;
            word-wrap: break-word;
            width: 100%;
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
            max-width: 500px;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            min-height: 400px;
            margin-left: auto;
            margin-right: auto; 
        }

        .panel-heading {
            font-size: 26px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .row {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .equal-height {
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%; 
        }

        @media (max-width: 768px) {
            .custom-panel {
                max-width: 100%;
                margin-left: 20px;
                margin-right: 20px;
            }
        }

        .welcome-message {
            font-size: 24px;
            color: #28a745;
            margin-bottom: 20px;
            font-weight: bold;
        }

    </style>

    <div class="text-center my-5">
        <h1 class="mb-5" style="color: #28a745;">Client Portal Menu</h1>
        <asp:Label runat="server" ID="welcomemessage" Text="" CssClass="welcome-message" />
        <h3 class="mb-4">Please select an option below:</h3>
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="custom-panel equal-height">
                    <h2 class="panel-heading">Manage Your Details and Applications</h2>
                    <div class="button-container">
                        <asp:Button runat="server" CssClass="custom-btn" Text="Edit or Delete Your Details" PostBackUrl="~/ClientPortal_MaintainClients.aspx"/>
                        <asp:Button ID="createApplicationButton" runat="server" CssClass="custom-btn" Text="Create a New Application" PostBackUrl="~/ClientPortal_AddApplicationDetails.aspx"/>
                        <asp:Button ID="maintainApplicationButton" runat="server" CssClass="custom-btn" Text="Edit or Delete Your Application" PostBackUrl="~/ClientPortal_MaintainApplications.aspx" />
                        <asp:Button ID="viewApplicationButton" runat="server" CssClass="custom-btn" Text="View Application" PostBackUrl="~/ClientPortal_ViewDocument.aspx"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
