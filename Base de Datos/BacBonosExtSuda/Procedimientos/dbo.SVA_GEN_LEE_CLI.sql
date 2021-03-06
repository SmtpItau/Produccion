USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_LEE_CLI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVA_GEN_LEE_CLI] 
(
          @clnombre1 CHAR(40)
)
AS
BEGIN

SET NOCOUNT ON 

	SET ROWCOUNT 50 


	       SELECT   clrut     ,
        	        cldv      ,
                	clcodigo  , 
	                clnombre  ,
        	        clgeneric ,
	                cldirecc  ,
	                clcomuna  ,
	                CLREGION  ,
	                clcompint ,
	                CLTIPCLI  ,
	                clfecingr ,
	                clctacte  ,
	                clfono    ,
	                clfax 	  ,
			'pais' = isnull((SELECT nombre FROM view_pais WHERE codigo_pais = CLPAIS),'País No Definido'),
		   clBrokers
		FROM  BacParamSuda..Cliente
		 WHERE  CLNOMBRE >= @clnombre1 
		 AND clbrokers='S' AND clvigente='S'
		 ORDER BY  CLNOMBRE

	SET ROWCOUNT 0

END

GO
