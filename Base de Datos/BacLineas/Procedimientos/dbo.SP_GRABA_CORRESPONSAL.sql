USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CORRESPONSAL]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CORRESPONSAL] ( @Rut_Cliente   numeric (9),
      @Codigo_Moneda   varchar (3),
      @Nombre_Corresponsal    varchar (45),
      @Cuenta_Corresponsal varchar (35),
      @Codigo_SWIFT   varchar (11),
--      @ccsuc   varchar ( 6),
      @Codigo_nemo            varchar (11),
      @Codigo_Cliente         numeric (9)
     )
AS
BEGIN
         SET NOCOUNT ON
 IF EXISTS(SELECT Rut_Cliente FROM cliente_corresponsal WHERE Rut_Cliente = @Rut_Cliente   
                                           AND Codigo_Cliente = @Codigo_Cliente) BEGIN
  UPDATE cliente_corresponsal
  SET         Rut_Cliente   = @Rut_Cliente   ,
    Codigo_Moneda    = @Codigo_Moneda   ,
    Nombre_Corresponsal     = @Nombre_Corresponsal  ,
    Cuenta_Corresponsal = @Cuenta_Corresponsal ,
    Codigo_SWIFT   = @Codigo_SWIFT  ,
    Codigo_nemo             = @Codigo_nemo          ,
    Codigo_Cliente   = @Codigo_Cliente       
   WHERE  Rut_Cliente = @Rut_Cliente  AND Codigo_Cliente = @Codigo_Cliente        
 END ELSE BEGIN
  INSERT cliente_corresponsal 
    (
    Rut_Cliente   ,
    Codigo_Moneda    ,
    Nombre_Corresponsal     ,
    Cuenta_Corresponsal ,
    Codigo_SWIFT   ,
    Codigo_nemo             ,
    Codigo_Cliente  
    )                   
  VALUES  
          ( 
    @Rut_Cliente   ,
    @Codigo_Moneda   ,
    @Nombre_Corresponsal    ,
    @Cuenta_Corresponsal ,
    @Codigo_SWIFT          ,
    @Codigo_nemo            ,
    @Codigo_Cliente           
    )
       END
   SET NOCOUNT OFF
   SELECT 'OK'
END
GO
