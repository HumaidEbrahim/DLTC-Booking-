<%@ Page Title="Admin Portal - Maintain CLients" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MaintainClients.aspx.cs" Inherits="DriversSystem.MaintainClients" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .table-container {
            margin: 50px auto;
            max-width: 1000px;
            text-align: center;
        }
        .crud-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .crud-table th, .crud-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .crud-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .crud-table td {
            background-color: #fff;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #28a745;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-container {
            display: flex;
            align-items: center;
        }
        .search-container input {
            padding: 10px;
            font-size: 16px;
            border: 2px solid #28a745;
            border-radius: 5px 0 0 5px;
            box-sizing: border-box;
        }
        .search-container button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }
        .search-container button:hover {
            background-color: white;
            color: #28a745;
            border-color: #28a745;
        }
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
        .btn-edit, .btn-delete, .btn-add-application {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin-right: 5px;
        }
        .btn-edit {
            background-color: #ffc107;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-add-application {
            background-color: #17a2b8;
            color: white;
        }
    </style>

    <div class="table-container">
        <h2>Maintain Clients</h2>
    </div>
 
    <!-- Success Alert -->
    <asp:Panel ID="successAlert" CssClass="alert alert-success alert-dismissible fade show" runat="server" Visible="false">
        <asp:Label ID="successMessage" runat="server"></asp:Label>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Error Alert -->
    <asp:Panel ID="errorAlert" CssClass="alert alert-danger alert-dismissible fade show" runat="server" Visible="false">
        <asp:Label ID="errorMessage" runat="server"></asp:Label>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <div class="action-bar">
        <!-- Search Bar on the Left -->
        <div class="search-container">
            <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Name or Surname..." OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>
            <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
        </div>

        <!-- Add Button on the Right -->
        <asp:Button ID="AddClientButton" runat="server" Text="Add New Client" CssClass="custom-btn" 
            OnClientClick="$('#AddModal').modal('show'); return false;" OnClick="AddClientButton_Click" />   
    </div>

    <!-- GridView -->
    <asp:GridView ID="ClientsGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table" OnSelectedIndexChanged="ClientsGridView_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="Client_ID" HeaderText="Client ID" />
            <asp:BoundField DataField="ID_Number" HeaderText="ID Number" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Surname" HeaderText="Surname" />
            <asp:BoundField DataField="Phone_Number" HeaderText="Phone Number" />
            <asp:BoundField DataField="Address_Number" HeaderText="Address Number" />
            <asp:BoundField DataField="Street_Address" HeaderText="Street Address" />
            <asp:BoundField DataField="City_ID" HeaderText="City ID" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                     OnClientClick='<%# "showUpdateModal(" + Eval("Client_ID") + "); return false;" %>' />
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                     OnClientClick='<%# "showDeleteModal(" + Eval("Client_ID") + "); return false;" %>' />
                    <asp:Button ID="AddApplicationButton" runat="server" Text="Add Application" CssClass="btn btn-add-application" 
                     OnClientClick='<%# "showAddApplicationModal(" + Eval("Client_ID") + "); return false;" %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </ContentTemplate>
    </asp:UpdatePanel>

    <!-- Add Modal -->
    <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Add Client</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="AddIDNumber" class="form-label">ID Number</label>
                        <asp:TextBox ID="AddIDNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddName" class="form-label">Name</label>
                        <asp:TextBox ID="AddName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddSurname" class="form-label">Surname</label>
                        <asp:TextBox ID="AddSurname" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddPhoneNumber" class="form-label">Phone Number</label>
                        <asp:TextBox ID="AddPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddAddressNumber" class="form-label">Address Number</label>
                        <asp:TextBox ID="AddAddressNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddStreetAddress" class="form-label">Street Address</label>
                        <asp:TextBox ID="AddStreetAddress" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="AddCityID" class="form-label">City ID</label>
                        <asp:DropDownList ID="AddCityID" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="SaveClientButton" runat="server" Text="Save" CssClass="custom-btn" OnClick="SaveClientButton_Click"/>
                    <asp:Button ID="CancelAddButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateModalLabel">Update Client</h5>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="UpdateClientID" runat="server" />
                    <div class="form-group">
                        <label for="UpdateIDNumber" class="form-label">ID Number</label>
                        <asp:TextBox ID="UpdateIDNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdateName" class="form-label">Name</label>
                        <asp:TextBox ID="UpdateName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdateSurname" class="form-label">Surname</label>
                        <asp:TextBox ID="UpdateSurname" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdatePhoneNumber" class="form-label">Phone Number</label>
                        <asp:TextBox ID="UpdatePhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdateAddressNumber" class="form-label">Address Number</label>
                        <asp:TextBox ID="UpdateAddressNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdateStreetAddress" class="form-label">Street Address</label>
                        <asp:TextBox ID="UpdateStreetAddress" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="UpdateCityID" class="form-label">City ID</label>
                        <asp:DropDownList ID="UpdateCityID" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="UpdateClientButton" runat="server" Text="Update" CssClass="custom-btn" OnClick="UpdateClientButton_Click"/>
                    <asp:Button ID="CancelUpdateButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#UpdateModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete Client</h5>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="DeleteClientID" runat="server" />
                    <p>Are you sure you want to delete this client?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="ConfirmDeleteButton" runat="server" Text="Delete" CssClass="custom-btn" OnClick="DeleteClientButton_Click"/>
                    <asp:Button ID="CancelDeleteButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Add Application Modal -->
    <div class="modal fade" id="AddApplicationModal" tabindex="-1" role="dialog" aria-labelledby="addApplicationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addApplicationModalLabel">Add Application</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="ApplicationClientID" class="form-label">Client ID</label>
                        <asp:TextBox ID="ApplicationClientID" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>