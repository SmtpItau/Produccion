USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEERCLIENTENOMBRE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEERCLIENTENOMBRE]
	(   @cNombre		VARCHAR(100)
	,	@SoloBancos		SMALLINT	= -1
	)
AS
BEGIN

   SET NOCOUNT ON

	SELECT  Nombre = clnombre
		,   Rut	  = CASE WHEN clcodigo < 9 THEN LTRIM(RTRIM( clrut )) + '0' + LTRIM(RTRIM( clcodigo ))
			 			 ELSE					LTRIM(RTRIM( clrut ))		+ LTRIM(RTRIM( clcodigo ))
		       	    END
	  FROM  BacParamSuda.dbo.CLIENTE with(nolock)
	 WHERE (Bloqueado	= 'N' OR Bloqueado	= '') 
	   AND (ClVigente	= 'S' OR ClVigente	= '')
	   AND (cltipcli	= @SoloBancos OR @SoloBancos = -1)
	   AND (clnombre	> @cNombre)   
  ORDER BY clnombre 

END
GO
