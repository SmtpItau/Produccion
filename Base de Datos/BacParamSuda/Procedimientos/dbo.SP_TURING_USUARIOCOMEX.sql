USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_USUARIOCOMEX]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TURING_USUARIOCOMEX]
						(@usuario as varchar(15),
                         @Existe   as varchar(01) OUTPUT)
AS 
BEGIN TRY
 SET NOCOUNT ON
   /* 
      declare @Res Varchar(1)
      exec SP_TURING_USUARIOCOMEX 'CAVENDANO', @Res output
      select @Res 

      exec SP_TURING_USUARIOCOMEX 'NPSIJAS', @Res output
      select @Res 

    */
   SELECT 'Nombre' = usr.nombre      
      ,   'Perfil' = CASE WHEN ltrim(rtrim( usr.Clase )) = '' THEN Tip.clase ELSE usr.clase END      
      ,   'MtoMax' = isnull( cto.Monto,   0.0)      
      ,   'Origen' = isnull( cla.nemo, '')      
      ,   'Glosa'  = isnull( cla.tbglosa, '')      
   into #TempUsuario
   FROM   BacParamSuda.dbo.USUARIO                         usr      
          LEFT JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO     tip ON usr.Tipo_Usuario = tip.Tipo_Usuario      
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cla ON cla.tbcateg      = 8602 and tbcodigo1 = usr.clase      
          LEFT JOIN (SELECT Monto  = ISNULL( MAX(montomax), 0.0)  
       ,  Perfil = perfil_comercial    
                      FROM BacCamSuda.dbo.COSTOS_COMEX, BacCamSuda..MEAC       
                     WHERE fecha = acfecpro       
        -- AND CodMoneda  = @iMoneda     
                  GROUP BY perfil_comercial )               cto ON cto.Perfil       = usr.clase      
   WHERE usr.usuario = @usuario   
         

	if exists(SELECT 1 FROM #TempUsuario WHERE  Perfil <> '' and Perfil <> 1 )
           begin
                select @Existe='S'
           end
        else
           begin
                select @Existe='N'
        end
    RETURN
 SET NOCOUNT OFF
END TRY

BEGIN CATCH
      select @Existe='N'      
      RETURN
END CATCH
GO
