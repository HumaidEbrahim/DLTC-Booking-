<%@ Page Title="Admin Portal - Mantain Clients" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantainClients.aspx.cs" Inherits="DriversSystem.MantainClients" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .table-container {
            margin: 50px auto;
            max-width: 800px;
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
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn-edit {
            background-color: #ffc107;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-add, .btn-csv {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            margin-right: 10px;
            cursor: pointer;
            border: none;
            color: white;
        }
        .btn-add {
            background-color: #28a745;
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

    </style>

    <div class="table-container">
        <h2>Maintain Clients</h2>
        <br /> <!-- Added a line break here -->

        <div>
            <!-- Modal: Add New Client -->
            <asp:Button ID="AddClientButton" runat="server" Text="Add New Client" CssClass="btn-add" 
                OnClientClick="$('#myModal').modal('show'); return false;" OnClick="AddClientButton_Click" />
        </div>

        <!-- The Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                   
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Client</h5>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">
                        <div class="form-container">
                            <p>Enter client details below:</p>

                            <div class="form-group">
                                <label for="IDNumber" class="form-label">ID Number</label>
                                <asp:TextBox ID="IDNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="Name" class="form-label">Name</label>
                                <asp:TextBox ID="Name" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="Surname" class="form-label">Surname</label>
                                <asp:TextBox ID="Surname" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="PhoneNumber" class="form-label">Phone Number</label>
                                <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="AddressNumber" class="form-label">Address Number</label>
                                <asp:TextBox ID="AddressNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="AddressStreet" class="form-label">Address Street</label>
                                <asp:TextBox ID="AddressStreet" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="CityID" class="form-label">City ID</label>
                                <asp:TextBox ID="CityID" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <asp:Button ID="SaveClientButton" runat="server" Text="Save" CssClass="btn-add"/>
                        <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn btn-light"  OnClientClick="$('#myModal').modal('hide'); return false;"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- GridView to Display Clients -->
        <asp:GridView ID="ClientsGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
            <Columns>
                <asp:BoundField DataField="Client_ID" HeaderText="Client ID" />
                <asp:BoundField DataField="ID_Number" HeaderText="ID Number" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Surname" HeaderText="Surname" />
                <asp:BoundField DataField="Phone_Number" HeaderText="Phone Number" />
                <asp:BoundField DataField="Address_Number" HeaderText="Address Number" />
                <asp:BoundField DataField="Address_Street" HeaderText="Address Street" />
                <asp:BoundField DataField="City_ID" HeaderText="City ID" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-edit" CommandName="Edit" />
                        <asp:Button ID="DeleteButton" runat="server" Text="Del" CssClass="btn btn-delete" CommandName="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</asp:Content>
