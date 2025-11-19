<%@ Page Title="" Language="C#" MasterPageFile="~/Daily Deli Master Page.Master" AutoEventWireup="true" CodeBehind="AboutProductCommentPage.aspx.cs" Inherits="Daily_Deli_E_Commerce.AboutProductCommentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #0077cc;
            --secondary: #0077cc;
            --accent: #0077cc;
            --light: #ffffff;
            --light-bg: #f8faff;
            --border: #e0e5f3;
            --text: #2d3748;
            --text-light: #718096;
            --success: #2ecc71;
            --glow: 0 5px 15px rgba(74, 108, 247, 0.1);
            --transition: 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", "Inter", sans-serif;
        }

        body {
            background: var(--light-bg);
            color: var(--text);
            font-size: 14px;
        }

        .comments-container {
            max-width: 800px;
            margin: 40px auto;
            background: var(--light);
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--glow);
            border: 1px solid var(--border);
        }

        .comments-container h1 {
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 20px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .comment-item {
            background: var(--light-bg);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .comment-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .comment-user {
            font-weight: 600;
            color: var(--primary);
        }

        .comment-likes {
            display: flex;
            align-items: center;
            color: var(--text-light);
        }

        .comment-likes i {
            margin-right: 5px;
            color: var(--success);
        }

        .comment-text {
            font-size: 16px;
            color: var(--text);
            margin-bottom: 10px;
        }

        .comment-date {
            font-size: 12px;
            color: var(--text-light);
            text-align: right;
        }

        .no-comments {
            text-align: center;
            color: var(--text-light);
            font-style: italic;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .comments-container {
                padding: 20px;
            }

            .comment-item {
                padding: 15px;
            }

            .comment-text {
                font-size: 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="comments-container">
        <h1>Top Comments for <asp:Literal ID="litProductName" runat="server"></asp:Literal></h1>
        <asp:Repeater ID="rptComments" runat="server">
            <ItemTemplate>
                <div class="comment-item">
                    <div class="comment-header">
                        <span class="comment-user"><%# Eval("UserName") %></span>
                        <span class="comment-likes"><i class="fas fa-thumbs-up"></i> <%# Eval("Likes") %></span>
                    </div>
                    <p class="comment-text"><%# Eval("Comment") %></p>
                    <p class="comment-date"><%# Eval("Date", "{0:MMMM dd, yyyy}") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Literal ID="litNoComments" runat="server" Visible="false"><p class="no-comments">No comments available for this product yet.</p></asp:Literal>
    </div>
</asp:Content>