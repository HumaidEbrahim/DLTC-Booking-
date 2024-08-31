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
      
    </div>
</asp:Content>

