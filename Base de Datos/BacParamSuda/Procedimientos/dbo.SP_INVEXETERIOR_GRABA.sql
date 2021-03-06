USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INVEXETERIOR_GRABA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_Graba    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_Graba    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_INVEXETERIOR_GRABA]
   (@Rut_Cliente numeric (9),
   @Codigo_Cliente numeric (9),
   @Nombre varchar (70),
   @Plazo numeric (5),
   @ArbSpo_Total numeric (19),
   @ArbSpo_Ocupado numeric (19),
   @ArbSpo_Disponible numeric (19),
   @ArbSpo_Exceso numeric (19),
   @ArbFwd_Total numeric (19),
   @ArbFwd_Ocupado numeric (19),
   @ArbFwd_Disponible numeric (19),
   @ArbFwd_Exceso numeric (19),
   @InvExt_Total numeric (19),
   @InvExt_Ocupado numeric (19),
   @InvExt_Disponible numeric (19),
   @ArbExt_Exceso numeric (19),
   @Fecha_Vencimiento datetime,
   @Fecha_Fin_Contrato datetime)
AS
BEGIN
        SET NOCOUNT ON
-- BEGIN TRANSACTION
 BEGIN
 if exists(SELECT rut_cliente FROM INVERSION_EXTERIOR WHERE rut_cliente=@Rut_Cliente)
  BEGIN 
  select 'MODIFICAR'
  UPDATE INVERSION_EXTERIOR SET
   rut_cliente  = @Rut_Cliente,
   codigo_cliente  =  @Codigo_Cliente,
   nombre   =  @Nombre,
   plazo   =  @Plazo,
   arbspo_total  =  @ArbSpo_Total,
   arbspo_ocupado  =  @ArbSpo_Ocupado,
   arbspo_disponible =  @ArbSpo_Disponible,
   arbspo_exceso  =  @ArbSpo_Exceso,
   arbfwd_total  =  @ArbFwd_Total,
   arbfwd_ocupado  =  @ArbFwd_Ocupado,
   arbfwd_disponible =  @ArbFwd_Disponible,
   arbfwd_exceso  =  @ArbFwd_Exceso,
   invext_total  =  @InvExt_Total,
   invext_ocupado  =  @InvExt_Ocupado,
   invext_disponible =  @InvExt_Disponible,
   arbext_exceso  =  @ArbExt_Exceso,
   fecha_vencimiento =  @Fecha_Vencimiento,
   fecha_fin_contrato = @Fecha_Fin_Contrato
    WHERE rut_cliente=@Rut_Cliente
    IF @@error<>0
       BEGIN
                   -- ROLLBACK TRANSACTION
                  SELECT 'NO ACTUALIZADO'
                    RETURN
                   END
   ---      COMMIT TRANSACTION
        SELECT 'OK' 
  END
 ELSE
  SELECT 'MODIFICAR'
  --BEGIN TRANSACTION
  INSERT INTO INVERSION_EXTERIOR
   (rut_cliente,
   codigo_cliente,
   nombre,
   plazo,
   arbspo_total,
   arbspo_ocupado,
   arbspo_disponible,
   arbspo_exceso,
   arbfwd_total,
   arbfwd_ocupado,
   arbfwd_disponible,
   arbfwd_exceso,
   invext_total,
   invext_ocupado,
   invext_disponible,
   arbext_exceso,
   fecha_vencimiento,
   fecha_fin_contrato)
     VALUES
   (@Rut_Cliente,
   @Codigo_Cliente,
   @Nombre,
   @Plazo,
   @ArbSpo_Total,
   @ArbSpo_Ocupado,
   @ArbSpo_Disponible,
   @ArbSpo_Exceso,
   @ArbFwd_Total,
   @ArbFwd_Ocupado,
   @ArbFwd_Disponible,
   @ArbFwd_Exceso,
   @InvExt_Total,
   @InvExt_Ocupado,
   @InvExt_Disponible,
   @ArbExt_Exceso,
   @Fecha_Vencimiento,
   @Fecha_Fin_Contrato)
  IF @@error<>0
                  BEGIN
                --  ROLLBACK TRANSACTION
                  SELECT 'NO INSERTADO'
                  RETURN
                END
  --COMMIT TRANSACTION
 END 
   SET NOCOUNT OFF
END
--select * from INVERSION_EXTERIOR
-- SP_HELP INVERSION_EXTERIOR
--Sp_InvExeterior_Graba INVERSION_EXTERIOR VALUES('1','1','DEUTSCHE BANK LONDON',1,999,998,1,0,999,998,1,0,999,998,1,0,'','')
--SP_HELPTEXT Sp_InvExeterior_Graba
GO
