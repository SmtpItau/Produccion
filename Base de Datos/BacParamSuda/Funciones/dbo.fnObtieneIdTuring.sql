USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fnObtieneIdTuring]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fnObtieneIdTuring]() returns int
as
begin
	
	return (select isnull(max(IdTuring),0) + 1 from Usuario)

end
GO
