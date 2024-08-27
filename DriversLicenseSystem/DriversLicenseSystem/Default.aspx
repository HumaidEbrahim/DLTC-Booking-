<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DriversLicenseSystem.Default" %>

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
            margin: 15px;
            border-radius: 5px;
            min-width: 200px;
        }

        .custom-btn:hover {
            background-color: white;
            color: #28a745;
            border-color: #28a745;
        }

        .custom-panel {
            background-color: white;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 40px;
            margin-top: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .panel-heading {
            font-size: 28px;
            color: #28a745;
            margin-bottom: 25px;
        }

        .intro-text {
            font-size: 18px;
            line-height: 1.6;
            color: #555555;
            margin-bottom: 30px;
            text-align: justify;
        }

        h1 {
            font-size: 36px;
            color: #28a745;
            margin-bottom: 30px;
            font-weight: bold;
        }

        h3 {
            font-size: 24px;
            color: #333333;
            font-weight: bold;
        }
    </style>

    <div class="text-center my-5">
        <h1>Welcome to the Department of Licensing</h1>

        <div class="custom-panel">
            <p class="intro-text">
                Welcome to the Licensing Department's official website! Our mission is to provide clear, efficient, and accessible licensing services to individuals and businesses alike. Whether you're applying for a new license or renewing an existing one, our website is your go-to resource. We are dedicated to ensuring that all licensing processes are straightforward, transparent, and tailored to meet your needs.
            </p>

            <h3 class="panel-heading">Please Select Your Desired Portal:</h3>

            <div class="d-flex justify-content-center">
                <a href="~/AdminPortal.aspx" runat="server" class="custom-btn">Admin Portal</a>
                <a href="~/ClientPortal.aspx" runat="server" class="custom-btn">Client Portal</a>
            </div>
        </div>
    </div>
</asp:Content>
