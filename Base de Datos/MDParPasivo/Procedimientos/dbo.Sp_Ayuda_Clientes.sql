USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ayuda_Clientes]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ayuda_Clientes]
        (@Sw            CHAR(30)    ,
         @Rut_Cliente   NUMERIC(9)=0)

AS BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

        IF @Sw = 'CASA MATRIZ' 
        BEGIN
	   SELECT 'RUT' = STR(clrut) + '-' + cldv
	   ,      clcodigo
           ,      clnombre
 	   ,      STR(clrut)
	   ,      cldv 
             FROM CLIENTE 
	    WHERE cltipcli = 1  
	      AND clcodigo = 1
         ORDER BY clnombre
	END

        IF @Sw = 'CASA MATRIZ TODAS' 
        BEGIN
	   SELECT 'RUT' = STR(clrut) + '-' + cldv
	   ,      clcodigo
	   ,      clnombre
	   ,      STR(clrut)
	   ,      cldv  
             FROM CLIENTE 
	    WHERE clclsbif = 'M' 
	      AND clcodigo = 1
 	 ORDER BY clnombre
	END

        IF @Sw = 'OTRAS'
        BEGIN
            SELECT 'RUT' = STR(clrut) + '-' + cldv
	    ,       clcodigo
	    ,       clnombre 
	    ,       STR(clrut)
	    ,       cldv  
               FROM CLIENTE 
	      WHERE cltipcli <> 1  
	        AND clcodigo = 1
	   ORDER BY clnombre
        END
      
        IF @Sw = 'FILIALES GRABADAS'
            BEGIN
            SELECT 'RUT' = STR(A.clrut) + '-' + A.cldv
	    ,       A.clcodigo
	    ,       A.clnombre 
	    ,       STR(A.clrut)+ STR(A.clcodigo)
              FROM CLIENTE          A,
                   LINEA_AFILIADO   B 
             WHERE A.clrut    = B.rutcasamatriz 
	       AND A.clcodigo = B.codigocasamatriz 
	       AND clcodigo   = 1
	  ORDER BY clnombre
            END
 
        IF @Sw = 'CASA MATRIZ POR CLIENTE' 
        BEGIN
	   SELECT 'RUT' = STR(clrut) + '-' + cldv
	  , 	  clcodigo
	  , 	  clnombre
	  , 	  STR(clrut)
	  , 	  cldv
             FROM CLIENTE 
	    WHERE rut_grupo <> 0 
              AND clclsbif  = 'M' 
              AND rut_grupo = @Rut_Cliente 
	      AND clcodigo  = 1
	 ORDER BY clnombre
	END
   SET NOCOUNT OFF 
END

GO
