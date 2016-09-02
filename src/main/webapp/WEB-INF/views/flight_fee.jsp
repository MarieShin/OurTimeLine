<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>FlightFee</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
	<form action="result" method="post">
		<div class="container">
			<h1 class="page-header title">�װ� ��� ����</h1>

			<!-- �ο� -->
			<div class="row">
				<label class="control-label col-md-2">�ο� :</label>
				<div class="col-md-10">
					<div class="form-group col-md-4">
						<label class="control-label col-sm-4">����</label>
						<div class="col-sm-8">
							<select class="form-control" name="adult">
								<option>0</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
							</select>
						</div>
					</div>
					<div class="form-group col-md-4">
						<label class="control-label col-sm-4">�Ҿ�</label>
						<div class="col-sm-8">
							<select class="form-control" name="young">
								<option>0</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
							</select>
						</div>
					</div>
					<div class="form-group col-md-4">
						<label class="control-label col-sm-4">����</label>
						<div class="col-sm-8">
							<select class="form-control" name="children">
								<option>0</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
							</select>
						</div>
					</div>

				</div>
			</div>

			<!-- ������ -->
			<div class="row">
				<label class="control-label col-sm-2">������ :</label>
				<div class="col-sm-10 destination">
					<div class="col-md-3">
						<label class="radio"><input
							type="radio" name="radio" value="la" checked>LA</label>
					</div>
					<div class=" col-md-3">
						<label class="radio"><input type="radio" name="radio"
							value="bk">����</label>
					</div>
					<div class=" col-md-3">
						<label class="radio"><input type="radio" name="radio"
							value="sd">�õ��</label>
					</div>

					<div class="col-md-3">
						<span class="badge" id="country"></span>
					</div>
				</div>
			</div>

			<!-- �װ��� -->
			<div class="form-inline row air_result">
				<label class="control-label col-sm-2">�װ��� :</label>
				<div class="col-sm-10">
					<span id="result"></span>
				</div>
			</div>
			<button type="submit" class="btn btn-primary btn_charge btn-lg"
				onclick="result">����ϱ�</button>

		</div>
	</form>
</body>
</html>