USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_Graba]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_BacMntCampos_Graba    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[Sp_BacMntCampos_Graba]
      (
       @id_sistema  CHAR(3),
       @tipo_movimiento CHAR(3),
       @tipo_operacion  CHAR(15),
       @glosa_movimiento CHAR(40),
       @glosa_operacion CHAR(40),
       @tipo_voucher        INT,  
       @tipo_movimientocaja    CHAR(1),   
       @control_instrumento    CHAR(1),   
       @control_moneda      CHAR(1), 
       @genera_dcto  CHAR(1)
      )
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

         INSERT INTO MOVIMIENTO_CNT VALUES(  @id_sistema,
       @tipo_movimiento,
              @tipo_operacion,
              @glosa_movimiento,
              @glosa_operacion,
              @tipo_voucher,         -- tipo de voucher    pendiente definición
              @tipo_movimientocaja,       -- tipo de movimiento caja ???
       @control_instrumento,      -- controla instrumento
              @control_moneda,       -- controla moneda
              @genera_dcto
      )
 SET NOCOUNT OFF
END
GO
