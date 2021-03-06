USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TYPE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TYPE]
            ( @Column VARCHAR(80), 
              @nombre CHAR(40) OUTPUT )
AS
BEGIN
 DECLARE @Tipo INTEGER
 
 SELECT @tipo=syscolumns.type
        FROM syscolumns 
        WHERE name=@Column
 
 SET ROWCOUNT 1
 SELECT @Nombre=Type_Name
        FROM MASTER.DBO.SPT_DATATYPE_INFO 
        WHERE ss_dtype=@Tipo
 SET ROWCOUNT 0
END

GO
