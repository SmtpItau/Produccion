USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMATO_INTERFAZ]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FORMATO_INTERFAZ]  
(   @Nombre_Interfaz CHAR(4)  
 ,  @Sistema   CHAR(3)  
 ,  @Id_Campo   INT  
 ,  @Tipo               INT  
 )   
AS   
BEGIN  
  
 SET NOCOUNT ON   
   
    IF @Tipo = 1   
    BEGIN  
        SELECT IdCampo            = vl.id_campo  
        ,      LargoCampo         = vl.largo  
        ,      PosicionDesde      = vl.desde  
        ,      PosicionHasta      = vl.hasta  
        ,      LargoHeader        = fm.Largo_encabezado  
        ,      LargoBody          = fm.Largo_cuerpo  
        ,      LargoControl       = fm.Largo_ultimo_registro  
        FROM   BacParamSuda.dbo.VALIDACIONES_INTERFACES  vl  
        INNER JOIN BacParamSuda.dbo.FORMATO_INTERFACES fm ON fm.Sistema = vl.Sistema AND fm.Id_interfaz = vl.Id_interfaz       
        WHERE  vl.nombre_interfaz = @Nombre_Interfaz  
        AND    vl.sistema         = @sistema  
        AND    vl.Tipo            = 'B'  
        AND    (vl.id_campo       = @Id_Campo OR @Id_Campo = 0)  
        ORDER BY  vl.id_campo  
    END  
  
    IF @Tipo = 2  
    BEGIN  
        SELECT nombre_interfaz, largo, desde, hasta  
        FROM   BacParamSuda.dbo.VALIDACIONES_INTERFACES   
        WHERE  sistema              = @sistema   
        AND    (( nombre_interfaz   LIKE ('%OP%') AND id_campo = 18 )  
        OR      ( nombre_interfaz   LIKE ('%BO%') AND id_campo = 10 )  
        OR      ( nombre_interfaz   LIKE ('%FL%') AND id_campo = 6  )  
        OR      ( nombre_interfaz   LIKE ('%DE%') and id_campo = 12 ) )  
        AND    Tipo                 = 'B'  
        ORDER BY Id_interfaz  
    END  
  
END
GO
