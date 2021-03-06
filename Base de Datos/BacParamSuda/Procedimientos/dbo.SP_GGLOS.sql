USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GGLOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_GGlos    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_GGlos    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GGLOS](@codigo       NUMERIC (9),
                          @cod          NUMERIC (9),
                          @descri       CHAR (35)
                         )
AS
BEGIN
set nocount on                         
  IF EXISTS (SELECT claglosa From ABREVIATURA_CLIENTE Where claglosa = @descri )
  --           AND    @cod= clacodigo AND @codigo=clarutcli )
 
 begin
          UPDATE ABREVIATURA_CLIENTE
          Set claglosa  = @descri,
              clacodigo = @cod,   
              clarutcli = @codigo
          Where claglosa = @descri 
--AND    @cod= clacodigo             AND @codigo=clarutcli
  END   
  ELSE
  BEGIN
        INSERT ABREVIATURA_CLIENTE
                  ( clarutcli,
                    clacodigo,
                    claglosa
                   )    
        VALUES (
                 @codigo ,
                 @cod ,
                 @descri
      
                
 )
END    
select 0
set nocount off
END             
--delete from Abreviatura_Cliente
--Sp_GGlos  1,2,'d'
--select * from Abreviatura_Cliente                                                                                                                                                                                                                        
GO
