<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${project}</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<style>
    #newTask{
        float: left;
        display:inline-block;
        border: 1px solid black;
        width: 250px;
        height: 300px;
        margin-left: 20px;
        margin-top: 20px;
        padding: 0;
        line-height: 270px;
        text-align: center;
        font-size: 150px;
    }
    #createTask{
        box-sizing: border-box;
        width: 100%;
        height: 100%;
        font-size: 150px;
        border: none;
        background-color: white;
    }
</style>
<body>
   <div id="newTask">
        <button type="button" id="createTask" onclick="open_layer();">+</button>
    </div>
     <script>
        function open_layer(){
           location.href = "${pageContext.request.contextPath}/task/createTask.jsp";
        }
     </script>
</body>
</html>