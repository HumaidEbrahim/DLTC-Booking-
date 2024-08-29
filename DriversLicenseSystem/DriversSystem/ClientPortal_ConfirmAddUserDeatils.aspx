<%@ Page Title="Client Portal - Confirm User Details" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ClientPortal_ConfirmAddUserDeatils.aspx.cs" Inherits="DriversSystem.ClientPortal_ConfirmAddUserDeatils" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            padding: 30px;
            max-width: 600px;
            margin: 0 auto; 
            margin-top: 50px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-heading {
            font-size: 28px;
            color: #28a745;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .continue-btn, .confirm-btn, .cancel-btn {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            margin: 20px auto 0; 
            border-radius: 5px;
            width: 100%;
            display: block;
        }

        .continue-btn {
            background-color: #28a745;
        }

        .confirm-btn {
            background-color: #28a745;
        }

        .cancel-btn {
            background-color: red;
            border-color: red;
        }

        .confirm-btn:hover, .cancel-btn:hover {
            background-color: white;
            color: #28a745;
        }

        .cancel-btn:hover {
            color: red;
        }

        .confirm-panel {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            display: none; 
        }

        .confirm-label {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .confirm-value {
            margin-bottom: 20px;
            color: #333;
        }
    </style>

    <div class="form-container">
        <h2 class="form-heading">Confirm Client Details</h2>

        <asp:Panel ID="ConfirmationPanel" runat="server">
            <!-- Name -->
            <div class="form-group">
                <label class="form-label">First Name:</label>
                <asp:Label ID="ConfirmName" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <!-- Surname -->
            <div class="form-group">
                <label class="form-label">Surname:</label>
                <asp:Label ID="ConfirmSurname" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <!-- Phone Number -->
            <div class="form-group">
                <label class="form-label">Phone Number:</label>
                <asp:Label ID="ConfirmPhoneNumber" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <!-- Address -->
            <div class="form-group">
                <label class="form-label">Address Number:</label>
                <asp:Label ID="ConfirmAddressNumber" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <div class="form-group">
                <label class="form-label">Address Street:</label>
                <asp:Label ID="ConfirmAddressStreet" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <!-- City -->
            <div class="form-group">
                <label class="form-label">City:</label>
                <asp:Label ID="ConfirmCity" runat="server" CssClass="form-control"></asp:Label>
            </div>

            <!-- Confirm and Cancel Buttons -->
            <asp:Button ID="ConfirmButton" runat="server" Text="Confirm" CssClass="continue-btn" OnClick="ConfirmButton_Click" />
            <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="continue-btn" OnClick="CancelButton_Click" />
        </asp:Panel>
    </div>
</asp:Content>

