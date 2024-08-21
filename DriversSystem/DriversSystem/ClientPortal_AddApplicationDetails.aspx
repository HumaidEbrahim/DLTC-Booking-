<%@ Page Title="Client Portal - Add Application"  Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientPortal_AddApplicationDetails.aspx.cs" Inherits="DriversSystem.ClientPortal_AddApplicationDetails" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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

        .form-control, .form-dropdown {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .form-control {
            margin-bottom: 15px;
        }

        .calendar-container {
            text-align: center; /* Center the calendar */
            margin-bottom: 15px;
        }

        .continue-btn {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            display: block;
            text-align: center;
            text-decoration: none;
            margin: 20px auto 0;
            border-radius: 5px;
            width: 100%;
        }

        .continue-btn:hover {
            background-color: white;
            color: #28a745;
        }

        .timeslot-group {
            margin-bottom: 15px;
        }
    </style>

    <div class="form-container">
        <h2 class="form-heading">Service Booking</h2>
        
        <div class="form-group">
            <label for="IDNumber" class="form-label">ID Number</label>
            <asp:TextBox ID="IDNumber" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="Service" class="form-label">Select Service</label>
            <asp:DropDownList ID="ServiceDropdown" runat="server" CssClass="form-control">
                <asp:ListItem Text="Learner's Appointment" Value="LearnerAppointment"></asp:ListItem>
                <asp:ListItem Text="License Appointment" Value="LicenseAppointment"></asp:ListItem>
                <asp:ListItem Text="Learner Issue" Value="LearnerIssue"></asp:ListItem>
                <asp:ListItem Text="License Issue" Value="LicenseIssue"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group calendar-container">
            <label for="SelectDate" class="form-label">Select Date</label>
            <asp:Calendar ID="SelectDateCalendar" runat="server" CssClass="form-control"></asp:Calendar>
        </div>

        <div class="form-group timeslot-group">
            <label for="SelectTimeslot" class="form-label">Select Timeslot</label>
            <asp:RadioButtonList ID="TimeslotRadioButtonList" runat="server" RepeatDirection="Vertical" CssClass="form-control">
                <asp:ListItem Text="8:00 AM - 9:00 AM" Value="8AM"></asp:ListItem>
                <asp:ListItem Text="9:00 AM - 10:00 AM" Value="9AM"></asp:ListItem>
                <asp:ListItem Text="10:00 AM - 11:00 AM" Value="10AM"></asp:ListItem>
                <asp:ListItem Text="11:00 AM - 12:00 PM" Value="11AM"></asp:ListItem>
                <asp:ListItem Text="12:00 PM - 1:00 PM" Value="12PM"></asp:ListItem>
                <asp:ListItem Text="1:00 PM - 2:00 PM" Value="1PM"></asp:ListItem>
                <asp:ListItem Text="2:00 PM - 3:00 PM" Value="2PM"></asp:ListItem>
                <asp:ListItem Text="3:00 PM - 4:00 PM" Value="3PM"></asp:ListItem>
                <asp:ListItem Text="4:00 PM - 5:00 PM" Value="4PM"></asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <asp:Button ID="ContinueButton" runat="server" Text="Continue" CssClass="continue-btn" />
    </div>
</asp:Content>
