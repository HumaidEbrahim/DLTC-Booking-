<%@ Page Title="Admin Portal - Mantain Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantainServices.aspx.cs" Inherits="DriversSystem.MantainServices" %>

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
        <h2>Maintain Services</h2>
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

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
    <ContentTemplate>
    <div class="action-bar">
        <!-- Search Bar on the Left -->
        <div class="search-container">
            <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Description..." OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>
            <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
        </div>

        <!-- Add Button on the Right -->
        <asp:Button ID="AddServiceButton" runat="server" Text="Add New Service" CssClass="custom-btn" 
            OnClientClick="$('#AddModal').modal('show'); return false;" />   
    </div>


    <!-- Get details from form for delete -->
      <script>
          function showDeleteModal(serviceID, serviceDescr, price) {
              document.getElementById('<%= DelServiceID.ClientID %>').value = serviceID;
              document.getElementById('<%= HiddenDelServiceID.ClientID %>').value = serviceID;
              document.getElementById('<%= DelServiceDescr.ClientID %>').value = serviceDescr;
              document.getElementById('<%= DelPrice.ClientID %>').value = price;
              $('#DeleteModal').modal('show');
    
          }
      </script>

          <!-- Get details from form for update -->
    <script>
        function showUpdateModal(serviceID, serviceDescr, price) {
            document.getElementById('<%= UpdateServiceID.ClientID %>').value = serviceID;
            document.getElementById('<%= HiddenUpdateServiceID.ClientID %>').value = serviceID;
            document.getElementById('<%= UpdateServiceDescr.ClientID %>').value = serviceDescr;
            document.getElementById('<%= UpdatePrice.ClientID %>').value = price;
            $('#UpdateModal').modal('show');
        }
    </script>

<!-- GridView -->
<asp:GridView ID="ServicesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
    <Columns>
        <asp:BoundField DataField="Service_ID" HeaderText="Service ID" />
        <asp:BoundField DataField="Service_Descr" HeaderText="Service Description" />
        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="R{0:F0}" />
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                 OnClientClick='<%# "showUpdateModal(\"" + Eval("Service_ID") + "\", \"" + Eval("Service_Descr") + "\", \"" + String.Format("{0:F0}", Eval("Price")) + "\"); return false;" %>' />
                <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                 OnClientClick='<%# "showDeleteModal(\"" + Eval("Service_ID") + "\", \"" + Eval("Service_Descr") + "\", \"" + String.Format("R{0:F0}", Eval("Price")) + "\"); return false;" %>' />
        </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
 </ContentTemplate>
</asp:UpdatePanel>

<!-- Delete Modal -->
<div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteLabel">Delete Service</h5>
            </div>
            <div class="modal-body">
                <div class="form-container">
                    <div class="form-group">
                        <label for="DelServiceID" class="form-label">Service ID</label>
                        <asp:TextBox ID="DelServiceID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        <asp:HiddenField ID="HiddenDelServiceID" runat="server" />
                    </div>
                    <div class="form-group">
                        <label for="DelServiceDescr" class="form-label">Service Description</label>
                        <asp:TextBox ID="DelServiceDescr" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="DelPrice" class="form-label">Price</label>
                        <asp:TextBox ID="DelPrice" runat="server" CssClass="form-control" Enabled="false" ></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                 <asp:Button ID="DeleteServiceButton" runat="server" Text="Delete" CssClass="custom-btn" OnClick="DeleteServiceButton_Click" />
                <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteModal').modal('hide'); return false;" />
            </div>
        </div>
    </div>
</div>

    <!-- Update Modal -->
<div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="updateLabel">Update Service</h5>
            </div>
            <div class="modal-body">
                <div class="form-container">
                    <div class="form-group">
                        <label for="UpdateServiceID" class="form-label">Service ID</label>
                        <asp:TextBox ID="UpdateServiceID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        <asp:HiddenField ID="HiddenUpdateServiceID" runat="server" />
                    </div>
                    <div class="form-group">
                        <label for="UpdateServiceDescr" class="form-label">Service Description</label>
                        <asp:TextBox ID="UpdateServiceDescr" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                        <span id="UpdateDescrWarning" class="text-danger" style="display: none;">Service Description must be between 1 and 50 characters.</span>
                    </div>
                    <div class="form-group">
                        <label for="UpdatePrice" class="form-label">Price</label>
                        <asp:TextBox ID="UpdatePrice" runat="server" CssClass="form-control" Enabled="true" ></asp:TextBox>
                        <span id="UpdatePriceWarning" class="text-danger" style="display: none;">Price must be a valid number between 10 and 1000.</span>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                 <asp:Button ID="UpdateServiceButton" runat="server" Text="Update" CssClass="custom-btn" OnClick="UpdateServiceButton_Click" OnClientClick="return validateForm('update','UpdateDescrWarning','UpdatePriceWarning') && true;"/>
                <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#UpdateModal').modal('hide'); return false;" />
            </div>
        </div>
    </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Service</h5>
            </div>
            <div class="modal-body">
                <div class="form-container">
                    <p>Enter service details below:</p>
                    <div class="form-group">
                        <label for="AddServiceDescr" class="form-label">Service Description</label>
                        <asp:TextBox ID="AddServiceDescr" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="AddDescrWarning" class="text-danger" style="display: none;">Service Description must be between 1 and 50 characters.</span>
                    </div>
                    <div class="form-group">
                        <label for="AddPrice" class="form-label">Service Price</label>
                        <asp:TextBox ID="AddPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="AddPriceWarning" class="text-danger" style="display: none;">Price must be a valid number between 10 and 1000.</span>
                    </div>                    
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="SaveServiceButton" runat="server" Text="Save" CssClass="custom-btn"  OnClientClick="return validateForm('add','AddDescrWarning','AddPriceWarning') && true;"  OnClick="SaveServiceButton_Click"/>
                <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" CausesValidation="false" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function validateForm(modalType, descrWarningId, priceWarningId) {
        var isValid = true;
        var serviceDescr, price;

        if (modalType === 'update') {
            serviceDescr = document.getElementById('<%= UpdateServiceDescr.ClientID %>').value;
            price = document.getElementById('<%= UpdatePrice.ClientID %>').value;
        } else if (modalType === 'add') {
            serviceDescr = document.getElementById('<%= AddServiceDescr.ClientID %>').value;
            price = document.getElementById('<%= AddPrice.ClientID %>').value; splay = 'none';
        }

        // Validate Service Description
        if (serviceDescr.length < 1 || serviceDescr.length > 50) {
            document.getElementById(descrWarningId).style.display = 'block';
            isValid = false;
        } else {
            document.getElementById(descrWarningId).style.display = 'none';
        }

        // Validate Price
        var priceValue = Number(price);
        if (!Number.isInteger(priceValue) || priceValue < 10 || priceValue > 1000) {
            document.getElementById(priceWarningId).style.display = 'block';
            isValid = false;
        } else {
            document.getElementById(priceWarningId).style.display = 'none';
        }

        return isValid;
       
    }
</script>




   

 <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</asp:Content>