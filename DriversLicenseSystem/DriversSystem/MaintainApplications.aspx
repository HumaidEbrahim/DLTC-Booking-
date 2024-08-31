<%@ Page Title="Admin Portal - Maintain Applications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainApplications.aspx.cs" Inherits="DriversSystem.MaintainApplications" %>

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
        .btn-edit {
            background-color: #ffc107;
            color: white;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
    </style>

    <div class="table-container">
        <h2>Maintain Applications</h2>
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
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Application ID..." OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
                </div>

                <!-- Add Button on the Right -->
                <asp:Button ID="AddApplicationButton" runat="server" Text="Add New Application" CssClass="custom-btn" 
                    OnClientClick="$('#AddModal').modal('show'); return false;" OnClick="AddApplicationButton_Click" />   
            </div>

            <!-- GridView -->
            <asp:GridView ID="ApplicationsGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table" OnRowEditing="ApplicationsGridView_RowEditing" OnRowCancelingEdit="ApplicationsGridView_RowCancelingEdit" OnRowUpdating="ApplicationsGridView_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="Application_ID" HeaderText="Application ID" ReadOnly="True" />
                    <asp:BoundField DataField="Client_ID" HeaderText="Client ID" ReadOnly="True" />
                    <asp:BoundField DataField="Time_ID" HeaderText="Time ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Is Paid?">
                        <ItemTemplate>
                            <asp:CheckBox ID="IsPaidCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsPaid")) %>' Enabled="False" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="IsPaidCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsPaid")) %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Is Attended?">
                        <ItemTemplate>
                            <asp:CheckBox ID="IsAttendedCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAttended")) %>' Enabled="False" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="IsAttendedCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAttended")) %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                                OnClientClick='<%# "showUpdateModal(\"" + Eval("Application_ID") + "\", \"" + Eval("Client_ID") + "\", \"" + Eval("Time_ID") + "\", \"" + Eval("IsPaid") + "\", \"" + Eval("IsAttended") + "\"); return false;" %>' />
                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                                OnClientClick='<%# "showDeleteModal(\"" + Eval("Application_ID") + "\", \"" + Eval("Client_ID") + "\", \"" + Eval("Time_ID") + "\", \"" + Eval("IsPaid") + "\", \"" + Eval("IsAttended") + "\"); return false;" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>

    <!-- Delete Modal -->
    <div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Application</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="DelApplicationID" class="form-label">Application ID</label>
                            <asp:TextBox ID="DelApplicationID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenDelApplicationID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="DelClientID" class="form-label">Client ID</label>
                            <asp:TextBox ID="DelClientID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="DelTimeID" class="form-label">Time ID</label>
                            <asp:TextBox ID="DelTimeID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="DelIsPaid" class="form-label">Is Paid?</label>
                            <asp:CheckBox ID="DelIsPaid" runat="server" Enabled="false" />
                        </div>
                        <div class="form-group">
                            <label for="DelIsAttended" class="form-label">Is Attended?</label>
                            <asp:CheckBox ID="DelIsAttended" runat="server" Enabled="false" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="DeleteConfirmButton" runat="server" Text="Delete" CssClass="custom-btn" OnClientClick="$('#DeleteModal').modal('hide'); $('#DeleteModal').on('hidden.bs.modal', function() { __doPostBack('<%= DeleteConfirmButton.UniqueID %>', ''); });" OnClick="DeleteConfirmButton_Click" />
                    <asp:Button ID="DeleteCancelButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="updateLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Application</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="UpdApplicationID" class="form-label">Application ID</label>
                            <asp:TextBox ID="UpdApplicationID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenUpdApplicationID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="UpdClientID" class="form-label">Client ID</label>
                            <asp:TextBox ID="UpdClientID" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdTimeID" class="form-label">Time ID</label>
                            <asp:TextBox ID="UpdTimeID" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdIsPaid" class="form-label">Is Paid?</label>
                            <asp:CheckBox ID="UpdIsPaid" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="UpdIsAttended" class="form-label">Is Attended?</label>
                            <asp:CheckBox ID="UpdIsAttended" runat="server" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="UpdateConfirmButton" runat="server" Text="Update" CssClass="custom-btn" OnClientClick="$('#UpdateModal').modal('hide'); $('#UpdateModal').on('hidden.bs.modal', function() { __doPostBack('<%= UpdateConfirmButton.UniqueID %>', ''); });" OnClick="UpdateConfirmButton_Click" />
                    <asp:Button ID="UpdateCancelButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#UpdateModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Add Modal -->
    <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="addLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Application</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="AddClientID" class="form-label">Client ID</label>
                            <asp:TextBox ID="AddClientID" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="AddTimeID" class="form-label">Time ID</label>
                            <asp:TextBox ID="AddTimeID" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="AddIsPaid" class="form-label">Is Paid?</label>
                            <asp:CheckBox ID="AddIsPaid" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="AddIsAttended" class="form-label">Is Attended?</label>
                            <asp:CheckBox ID="AddIsAttended" runat="server" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="AddConfirmButton" runat="server" Text="Add" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); $('#AddModal').on('hidden.bs.modal', function() { __doPostBack('<%= AddConfirmButton.UniqueID %>', ''); });" OnClick="AddConfirmButton_Click" />
                    <asp:Button ID="AddCancelButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showDeleteModal(applicationID, clientID, timeID, isPaid, isAttended) {
            document.getElementById('<%= DelApplicationID.ClientID %>').value = applicationID;
            document.getElementById('<%= DelClientID.ClientID %>').value = clientID;
            document.getElementById('<%= DelTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= DelIsPaid.ClientID %>').checked = isPaid === "True";
            document.getElementById('<%= DelIsAttended.ClientID %>').checked = isAttended === "True";
            $('#DeleteModal').modal('show');
        }

        function showUpdateModal(applicationID, clientID, timeID, isPaid, isAttended) {
            document.getElementById('<%= UpdApplicationID.ClientID %>').value = applicationID;
            document.getElementById('<%= UpdClientID.ClientID %>').value = clientID;
            document.getElementById('<%= UpdTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= UpdIsPaid.ClientID %>').checked = isPaid === "True";
            document.getElementById('<%= UpdIsAttended.ClientID %>').checked = isAttended === "True";
            $('#UpdateModal').modal('show');
        }
    </script>

</asp:Content>
