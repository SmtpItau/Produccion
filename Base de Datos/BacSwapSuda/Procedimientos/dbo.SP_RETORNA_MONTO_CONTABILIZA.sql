USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_MONTO_CONTABILIZA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_RETORNA_MONTO_CONTABILIZA]( 
                                          @ID_Sistema       CHAR(3)    ,
                                          @Tipo_Movimiento  CHAR(3)    ,
                                          @Tipo_Operacion   CHAR(5)    ,
                                          @Operacion        NUMERIC(10),
                                          @Correlativo      NUMERIC,
                                          @Codigo_Campo     NUMERIC(03), 
                                          @Monto            NUMERIC(18,2) OUTPUT ) 
AS
BEGIN

DECLARE @Cmd_Sql       VARCHAR(255),
        @Nombre_Campo  CHAR(30)

--print 'para sacar campo'
/*
select @ID_Sistema
select @Tipo_Movimiento
select @Tipo_Operacion
select @Codigo_Campo
*/
SELECT @Nombre_Campo = Nombre_Campo_Tabla
  FROM VIEW_CAMPO_CNT 
 WHERE ID_Sistema                = @ID_Sistema
   AND Tipo_Movimiento           = @Tipo_Movimiento
   AND Tipo_Operacion            = @Tipo_Operacion
   AND Codigo_Campo              = @Codigo_Campo
   AND Tipo_Administracion_Campo = 'F'  

DELETE BAC_CNT_CONTABILIZA_PASO
IF @@ERROR <> 0
BEGIN
     PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'  
     RETURN 1
END

/* BUSCA EL VALOR DEL CAMPO A CONTABILIZAR ---------------------------------------------- */
-- select * from BAC_CNT_CONTABILIZA_PASO / select * from VIEW_CAMPOS_CNT
/*
print 'alcanza'
select @Nombre_Campo
select @ID_Sistema
select @Tipo_Movimiento --select * from bac_cnt_contabiliza
select @Tipo_Operacion  ---select * from bac_cnt_perfil_detalle
select @Operacion
select @Correlativo --dbo.sp_help
print 'fin alcanza'
*/
SELECT @Cmd_Sql = 'INSERT BAC_CNT_CONTABILIZA_PASO( Monto ) SELECT ' + RTRIM(@Nombre_Campo)  
SELECT @Cmd_Sql = @Cmd_Sql + ' FROM BAC_CNT_CONTABILIZA WHERE '  
SELECT @Cmd_Sql = @Cmd_Sql + ' ID_Sistema      = ''' + RTRIM(@ID_Sistema)		+ ''' AND ' 
SELECT @Cmd_Sql = @Cmd_Sql + ' Tipo_Movimiento = ''' + RTRIM(@Tipo_Movimiento)	+ ''' AND '  
SELECT @Cmd_Sql = @Cmd_Sql + ' Tipo_Operacion  = ''' + RTRIM(@Tipo_Operacion)	+ ''' AND '  
SELECT @Cmd_Sql = @Cmd_Sql + ' Operacion       =  ' + LTRIM(STR(@Operacion))		+ ' AND '  
SELECT @Cmd_Sql = @Cmd_Sql + ' Correlativo     =  ' + LTRIM(STR(@Correlativo))  
--int @cmd_sql
--select (@Cmd_Sql)
EXECUTE (@Cmd_Sql)

IF @@ERROR <> 0
BEGIN
     PRINT 'ERROR_PROC FALLA ACTUALIZANDO CONTABILIZA PASO CON MONTO.'  
     RETURN 1
END

SELECT @Monto = ISNULL(Monto, 0) FROM BAC_CNT_CONTABILIZA_PASO

RETURN 0

END   /* FIN PROCEDIMIENTO */


--lect * from VIEW_CAMPOS_CNT
--select * from 


GO
