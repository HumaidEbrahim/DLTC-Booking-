<%@ Page Title="Maintain Clients - edit or delete appkication" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ClientPortal_MaintainApplications.aspx.cs" Inherits="DriversSystem.ClientPortal_MaintainApplications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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

        .dropdown-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: white;
            color: #333;
        }

        .btn {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            width: 48%;
            margin: 10px 1%;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background-color: #ffc107;
            color: #333;
            border: 2px solid #ffc107;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: white;
            color: #ffc107;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background-color: white;
            color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: 2px solid #dc3545;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background-color: white;
            color: #dc3545;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }
    </style>

    <div class="form-container">
        <h2 class="form-heading">Edit or Delete Application Details</h2>

        <div class="form-group">
            <label for="ApplicationID" class="form-label">Application ID</label>
            <asp:TextBox ID="ApplicationID" runat="server" CssClass="form-control" Enabled="False" />
        </div>
        
        <asp:Panel ID="FormState" runat="server"> 
            <div class="form-group">
                <label for="Service" class="form-label">Service</label>
                <asp:DropDownList ID="Service" runat="server" CssClass="dropdown-control" Enabled="True"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="ServiceRequired" runat="server" ControlToValidate="Service" ErrorMessage="Service is required!" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="ApplicationDate" class="form-label">Date</label>
                <asp:TextBox ID="ApplicationDate" runat="server" CssClass="form-control" Enabled="True" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="DateRequired" runat="server" ControlToValidate="ApplicationDate" ErrorMessage="Date is required!" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label for="ApplicationTime" class="form-label">Time</label>
                <asp:TextBox ID="ApplicationTime" runat="server" CssClass="form-control" Enabled="True" TextMode="Time"></asp:TextBox>
                <asp:RequiredFieldValidator ID="TimeRequired" runat="server" ControlToValidate="ApplicationTime" ErrorMessage="Time is required!" Display="Dynamic" />
            </div>
        </asp:Panel>

        <asp:Panel ID="ApplicationDetailsPanel" runat="server" CssClass="button-group">
            <asp:Button ID="UpdateButton" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="UpdateButton_Click" />
            <asp:Button ID="SaveButton" runat="server" Text="Save" CssClass="btn btn-success" OnClick="SaveButton_Click" Visible="false" />
            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-danger" OnClientClick="$('#DeleteConfirmModal').modal('show'); return false;" OnClick="DeleteButton_Click" />
        </asp:Panel>
    </div>

    <!-- Delete Confirm Modal -->
    <div class="modal fade" id="DeleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteConfirmLabel">Are you sure you want to delete this application?</h5>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="DeleteConfirmButton" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" OnClick="DeleteConfirmButton_Click" />
                    <asp:Button ID="CancelDeleteButton" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClientClick="$('#DeleteConfirmModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
