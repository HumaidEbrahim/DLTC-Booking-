<%@ Page Title="CLient Portal - Edit and Delete CLient" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientPortal_MaintainClients.aspx.cs" Inherits="DriversSystem.ClientPortal_MaintainClients" %>

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
            position: relative;
            background-repeat: no-repeat;
            background-position: right 10px center;
        }

        .dropdown-control:focus {
            outline: none;
            border-color: #28a745;
        }

       .dropdown-control:disabled {
                background-color: #e9ecef;
                color: #6c757d;
                cursor: not-allowed;
                opacity: 0.65;
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
        <h2 class="form-heading">Edit or Delete Client Details</h2>

        <div class="form-group">
            <label for="IDNumber" class="form-label">ID Number</label>
            <asp:TextBox ID="IDNumber" runat="server" CssClass="form-control" Enabled="False" />
        </div>
        
        <asp:Panel ID="FormState" runat="server"> 
        <div class="form-group">
            <label for="Name" class="form-label">First name</label>
            <asp:TextBox ID="Name" runat="server" CssClass="form-control" Enabled="True" />
            <asp:RequiredFieldValidator ID="NameRequired" runat="server" ControlToValidate="Name" ErrorMessage="Name is required!" Display="Dynamic"  />
            <asp:RegularExpressionValidator ID="NameRegex" runat="server" ControlToValidate="Name" ErrorMessage="Name can only contain letters!"  Display="Dynamic" ValidationExpression="^[a-zA-Z\s]+$" />
        </div>

        <div class="form-group">
            <label for="Surname" class="form-label">Surname</label>
            <asp:TextBox ID="Surname" runat="server" CssClass="form-control"  Enabled="True"/>
            <asp:RequiredFieldValidator ID="SurnameRequired" runat="server" ControlToValidate="Surname" ErrorMessage="Surname is required!"  Display="Dynamic" />
            <asp:RegularExpressionValidator ID="SurnameRegex" runat="server" ControlToValidate="Surname" ErrorMessage="Surname can only contain letters!" Display="Dynamic" ValidationExpression="^[a-zA-Z\s]+$" />
        </div>

        <div class="form-group">
            <label for="PhoneNumber" class="form-label">Phone Number</label>
            <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control"  Enabled="True"></asp:TextBox>
            <asp:RequiredFieldValidator ID="NumberRequired" runat="server" ControlToValidate="PhoneNumber" ErrorMessage="Phone number is required!" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="PhoneNumber" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationExpression="^0\d{9}\s*$" />
        </div>
        
        <div class="form-group">
            <label for="AddressNumber" class="form-label">Address Number</label>
            <asp:TextBox ID="AddressNumber" runat="server" CssClass="form-control"  Enabled="True"></asp:TextBox>
            <asp:RequiredFieldValidator ID="AddressNumRequired" runat="server" ControlToValidate="AddressNumber" ErrorMessage="Address number is required!" Display="Dynamic" />
        </div>
        
        <div class="form-group">
            <label for="AddressStreet" class="form-label">Address Street</label>
            <asp:TextBox ID="AddressStreet" runat="server" CssClass="form-control"  Enabled="True"></asp:TextBox>
            <asp:RequiredFieldValidator ID="AddressStreetRequired" runat="server" ControlToValidate="AddressStreet" ErrorMessage="Street Address is required!"  Display="Dynamic" />
        </div>
       
        <div class="form-group">
            <label for="City" class="form-label">City</label>
            <asp:DropDownList ID="City" runat="server" CssClass="dropdown-control"  Enabled="True"></asp:DropDownList>
        </div>
            </asp:Panel>

        <asp:Panel ID="ClientDetailsPanel" runat="server" CssClass="button-group">
            <asp:Button ID="UpdateButton" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="UpdateButton_Click" />
            <asp:Button ID="SaveButton" runat="server" Text="Save" CssClass="btn btn-success" OnClick="SaveButton_Click" Visible="false" />
            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-danger" OnClientClick="$('#DeleteConfirmModal').modal('show'); return false;" OnClick="DeleteButton_Click"  />
        </asp:Panel>
    </div>

        <!-- Delete Confirm Modal -->
    <div class="modal fade" id="DeleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
             <h5 class="modal-title" id="deleteconfirmLabel">Are you sure you want to delete?</h5>
            <div class="modal-footer">
                 <asp:Button ID="DeleteConfirmButton" runat="server" Text="Confirm Delete" CssClass="custom-btn" OnClick="DeleteConfirmButton_Click" />
                <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteConfirmModal').modal('hide'); return false;" />
                 </div>
            </div>
        </div>
    </div>
</div>

</asp:Content>
