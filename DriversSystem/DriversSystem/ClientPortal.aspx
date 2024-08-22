<%@ Page Title="Client Portal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientPortal.aspx.cs" Inherits="DriversSystem.ClientPortal1" %>

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
       <asp:Panel ID="idAlert" CssClass="alert alert-danger" runat="server" Visible="true">
            Invalid ID number. Please try again.
        </asp:Panel>

        <div class="panel-body">
            <p>Please enter your South African ID Number</p>
        </div>
        <div class="form-group">
        <asp:TextBox ID="clientId" runat="server" CssClass="form-control" Placeholder="Enter Your ID Number"></asp:TextBox>
    </div>

    <div class="text-center">
     <asp:Button ID="bttnEnterID" runat="server" Text="Search" OnClick="bttnIDEnter_Click" CssClass="search-btn" />
</div>
    </div>
</asp:Content>
