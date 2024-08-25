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
    <asp:Panel ID="successAlert" CssClass="alert alert-success" runat="server" Visible="false">
        <asp:Label ID="successMessage" runat="server"></asp:Label>
    </asp:Panel>

    <!-- Error Alert -->
    <asp:Panel ID="errorAlert" CssClass="alert alert-danger alert-dismissible fade show" runat="server" Visible="false">
        <asp:Label ID="errorMessage" runat="server"></asp:Label>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
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


    <!-- Get details from from for delete -->
      <script type="text/javascript">
          function showDeleteModal(serviceID, serviceDescr, price) {
              document.getElementById('<%= DelServiceID.ClientID %>').value = serviceID;
              document.getElementById('<%= HiddenDelServiceID.ClientID %>').value = serviceID;
        document.getElementById('<%= DelServiceDescr.ClientID %>').value = serviceDescr;
        document.getElementById('<%= DelPrice.ClientID %>').value = price;

              $('#DeleteModal').modal('show');
          }
      </script>

<!-- GridView -->
<asp:GridView ID="ServicesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
    <Columns>
        <asp:BoundField DataField="Service_ID" HeaderText="Service ID" />
        <asp:BoundField DataField="Service_Descr" HeaderText="Service Description" />
        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-edit" CommandName="Edit" />
                <asp:Button ID="DeleteButton" runat="server" Text="Del" CssClass="btn btn-delete" CommandName="Delete" 
     OnClientClick='<%# "showDeleteModal(\"" + Eval("Service_ID") + "\", \"" + Eval("Service_Descr") + "\", \"" + String.Format("{0:C}", Eval("Price")) + "\"); return false;" %>' />


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
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
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

<!-- Add Modal -->
<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Service</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-container">
                    <p>Enter service details below:</p>
                    <div class="form-group">
                        <label for="AddServiceDescr" class="form-label">Service Description</label>
                        <asp:TextBox ID="AddServiceDescr" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="serviceDescrWarning" class="text-danger" style="display: none;">Service Description must be between 1 and 50 characters.</span>
                    </div>
                    <div class="form-group">
                        <label for="AddPrice" class="form-label">Service Price</label>
                        <asp:TextBox ID="AddPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="priceWarning" class="text-danger" style="display: none;">Price must be a valid number between 10 and 1000.</span>
                    </div>                    
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="SaveServiceButton" runat="server" Text="Save" CssClass="custom-btn" OnClick="SaveServiceButton_Click" UseSubmitBehavior="false" OnClientClick="return validateForm();" />
                <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" CausesValidation="false" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function validateForm() {
        var isValid = true;
        var serviceDescr = document.getElementById('<%= AddServiceDescr.ClientID %>').value;
        var price = document.getElementById('<%= AddPrice.ClientID %>').value;

        // Validate Service Description
        if (serviceDescr.length < 1 || serviceDescr.length > 50) {
            document.getElementById('serviceDescrWarning').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('serviceDescrWarning').style.display = 'none';
        }

        // Validate Price
        var priceValue = parseFloat(price);
        if (isNaN(priceValue) || priceValue < 10.00 || priceValue > 1000.00) {
            document.getElementById('priceWarning').style.display = 'block';
            isValid = false;
        } else {
            document.getElementById('priceWarning').style.display = 'none';
        }

        return isValid;
    }

    // Add event listeners to clear warnings when user starts typing
    document.getElementById('<%= AddServiceDescr.ClientID %>').addEventListener('input', function() {
        document.getElementById('serviceDescrWarning').style.display = 'none';
    });

    document.getElementById('<%= AddPrice.ClientID %>').addEventListener('input', function () {
        document.getElementById('priceWarning').style.display = 'none';
    });
</script>


   

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</asp:Content>