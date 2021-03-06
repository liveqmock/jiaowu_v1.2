<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">


<link type="text/css" href="/css/css/bootstrap.min.css" rel="stylesheet" />
<link type="text/css" href="/css/css/style.css" rel="stylesheet" />
<link href="/font-awesome/css/font-awesome.css?v=1.7" rel="stylesheet">
<link href="/css/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="/css/css/plugins/chosen/chosen_style.css" rel="stylesheet">

<!-- Morris -->
<link href="/css/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<!-- Gritter -->
<link href="/js/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">
<link href="/css/css/animate.css" rel="stylesheet">

<script type="text/javascript" src="/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<link rel="shortcut icon" href="/images/ico/favicon.ico" />
<script type="text/javascript">

</script>
<title>${_res.get('class_type_management')}</title>

<style type="text/css">
label{
  height:34px;
  width:80px;
}
.subject_name{
  width:520px;
  margin:-50px 0 0 82px;
}
.class_type{
  margin:-50px 0 40px 82px;
}
#classtype div{
  float:left;
  margin-right:15px  
} 
.student_list_wrap {
	position: absolute;
	top: 100px;
	left: 9.5em;
	width: 100px;
	overflow: hidden;
	z-index: 2012;
	background: #09f;
	border: 1px solide;
	border-color: #e2e2e2 #ccc #ccc #e2e2e2;
	padding: 6px;
}
</style>
</head>
<body style="background:#fff">
	<div class="ibox-content" style="width: 480px; height: 380px;">
		<form action="" method="post" id="/courseplan/UpdateTeachers"
			name="form1">
			<input type="hidden" value="${ids }" id="ids">
			<div>
				<label>${_res.get('teacher')}：</label>
			</div>
			<div style="display: inline;">
				<div style="float: left">
					<select id="teacherids" class="chosen-select" style="width: 260px;"
						tabindex="2" name="_query.teacherId">
						<option value="">${_res.get('Please.select')}</option>
						<c:forEach items="${teacherList}" var="teacher">
							<option value="${teacher.id }"
								<c:if test="${teacher.id == paramMap['_query.teacherId'] }">selected="selected"</c:if>>${teacher.REAL_NAME }</option>
						</c:forEach>
					</select>
				</div>
				<br><br><br><br><br><br><br><br>
				<div style="float: left;">
					<input type="button" onclick="batchUpdateTeacher()"
						id="updateTeacher" value="${_res.get('Modify')}"
						class="btn btn-outline btn-primary">
				</div>
			</div>
		</form>
		<div style="display: none" id="piaoo">
			<h5 onclick="closepiao();">
				<span id="batchUpdateCloseBtn"
					title="${_res.get('admin.common.close')}">X</span>
			</h5>
		</div>
	</div>
	<!-- Mainly scripts -->
    <script src="/js/js/bootstrap.min.js?v=1.7"></script>
    <script src="/js/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="/js/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <!-- Custom and plugin javascript -->
    <script src="/js/js/hplus.js?v=1.7"></script>
    <!-- layer javascript -->
	<script src="/js/js/plugins/layer/layer.min.js"></script>
	<script>
        layer.use('extend/layer.ext.js'); //载入layer拓展模块
    </script>
    <script>
       $('li[ID=nav-nav6]').removeAttr('').attr('class','active');
       
     //弹出后子页面大小会自动适应
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.iframeAuto(index);
    </script>
    
     <script type="text/javascript">
     		// 批量修改教师
    		function batchUpdateTeacher() {
    			var ids = $("#ids" ).val() ;
    			var teacherId = $('#teacherids option:selected').val() ;
    		 	if(teacherId==null||teacherId==""){
    		 		layer.msg("${_res.get('atLeastOnTeacher')}");
    				return false;
    		 	}else{
    		 		$.layer({
						    shade : [0],
							title:["${_res.get('Message')}",true],
						    area : ['auto','auto'],
						    dialog : {
						        msg:"${_res.get('updateConfirm')}",
						        btns : 2, 
						        type : 4,
						        btn : ["${_res.get('admin.common.determine')}","${_res.get('Cancel')}"],
						        yes : function(){
			    		 			$.ajax({
			    	        			url:"${cxt}/courseplan/batchUpdateTeacher",
			    	        			type:"post",
			    	        			cache: false,
			    	        			data:{"ids":ids,"teacherid":teacherId},
			    	        			dataType:"json",
			    	        			success:function(data){
			    	        				if(data.code=="1"){
			    	        					errorMessage = "您选择的教师"+data.teacher+"在"+(data.time).replace('00:00:00',data.hour)+"有排课/排休！"+"请重新选择";
			    	        					layer.msg(errorMessage,2,2) ;
			    	        					parent.location.reload();
			    	        				}
			    	        				if(data.code=="0"){
			    	        					layer.msg(data.result,2,1) ;
			    	        					parent.search()	  ;  
			    	        				}
			    	        			}
			    	    			} )
			    		 			
						}
						}
						})
    		 	}
    		}
    
    </script>
	
    <!-- Chosen -->
	<script src="/js/js/plugins/chosen/chosen.jquery.js"></script>
	<script>
	$(".chosen-select").chosen({disable_search_threshold:30});
		var config = {
			'.chosen-select' : {},
			'.chosen-select-deselect' : {
				allow_single_deselect : true
			},
			'.chosen-select-no-single' : {
				disable_search_threshold : 10
			},
			'.chosen-select-no-results' : {
				no_results_text : 'Oops, nothing found!'
			},
			'.chosen-select-width' : {
				width : "95%"
			}
		}
		for ( var selector in config) {
			$(selector).chosen(config[selector]);
		}
	</script>
</body>
</html>
