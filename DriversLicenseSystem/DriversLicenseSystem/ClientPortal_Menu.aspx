<%@ Page Title ="Client Menu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientPortal_Menu.aspx.cs" Inherits="DriversLicenseSystem.ClientPortal_Menu" %>

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
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .panel-heading {
            font-size: 26px;
            color: #28a745;
            margin-bottom: 20px;
            text-align: center;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Center the columns */
        }

        .col-md-6 {
            flex: 0 0 50%;
            max-width: 50%;
            padding: 15px;
        }

        @media (max-width: 768px) {
            .col-md-6 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }
    </style>

    <div class="text-center my-5">
        <h1 class="mb-5" style="color: #28a745;">Client Portal</h1>
        <h3 class="mb-4">Please select an option below:</h3>
        <div class="custom-panel">
            <div class="row mt-4">
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Book an Appointment" />
                </div>
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Edit User Details" />
                </div>
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Delete User Details" />
                </div>
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Edit User Application" />
                </div>
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="Delete User Application" />
                </div>
                <div class="col-md-6">
                    <asp:Button runat="server" CssClass="custom-btn" Text="View Application" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
