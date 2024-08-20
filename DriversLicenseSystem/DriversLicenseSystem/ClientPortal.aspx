<%@ Page Title="Client Portal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientPortal.aspx.cs" Inherits="DriversLicenseSystem.ClientPortal" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .custom-panel {
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            padding: 30px;
            margin-top: 50px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .panel-heading {
            font-size: 26px;
            color: #28a745;
            margin-bottom: 20px;
            text-align: center;
        }

        .panel-body {
            font-size: 18px;
            margin-bottom: 30px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: center;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #28a745;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .search-btn {
            padding: 10px 20px;
            font-size: 18px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
            margin-top: 10px;
        }

        .search-btn:hover {
            background-color: white;
            color: #28a745;
        }
    </style>

    <div class="custom-panel">
        <h2 class="panel-heading">Welcome Client</h2>
        <div class="panel-body">
            <p>Please enter your Client ID below to search for your details.</p>
        </div>
        <div class="form-group">
            <label for="clientId">Client ID</label>
            <input type="text" id="clientId" class="form-control" placeholder="Enter Client ID">
        </div>
        <div class="text-center">
            <button type="button" class="search-btn">Search</button>
        </div>
    </div>
</asp:Content>
