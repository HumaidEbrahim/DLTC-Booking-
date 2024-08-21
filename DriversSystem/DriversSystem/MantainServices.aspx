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
        <h2>Maintain Services</h2>
         <div>

<!-- Modal: add -->
     <asp:Button ID="AddServiceButton" runat="server" Text="Add New Service" CssClass="btn-add" 
         OnClientClick="$('#myModal').modal('show'); return false;"/>
</div>

  <!-- The Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
           
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Service</h5>
                
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                

                <div class="form-container">
                    <p>Enter service details below:</p>
                    

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
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <asp:Button ID="SaveServiceButton" runat="server" Text="Save" CssClass="btn-add"/>
                <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn btn-light"  OnClientClick="$('#myModal').modal('hide'); return false;"/>
               
                 
                </button>
            </div>
        </div>
    </div>
</div>
        <!-- Gridview -->

        <asp:GridView ID="ServicesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
            <Columns>
                <asp:BoundField DataField="Service_ID" HeaderText="Service ID" />
                <asp:BoundField DataField="Service_Descr" HeaderText="Service Description" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />

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
