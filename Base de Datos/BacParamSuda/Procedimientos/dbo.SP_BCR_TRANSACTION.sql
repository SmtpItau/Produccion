USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BCR_TRANSACTION]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Bcr_Transaction    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
CREATE PROCEDURE [dbo].[SP_BCR_TRANSACTION]
 (@sw CHAR(1))
AS BEGIN
 
 IF @sw<>'B' AND @sw<>'C' AND @sw<>'R'
    BEGIN
            SELECT sw='NO HAY'
           END
 ELSE
    BEGIN
  IF @sw='B'
     BEGIN
   BEGIN TRANSACTION
   SELECT sw=@sw
     END
  IF @sw='C'
     BEGIN
   COMMIT TRANSACTION
   SELECT sw=@sw
       END
         
  IF @sw='R'
     
  BEGIN
  
   ROLLBACK TRANSACTION
   SELECT sw=@sw
  END
        
    
 END
END
--Sp_Bcr_Transaction 'C'
--DECLARE SW CHAR(1)
 
-- begin transaction
 --SELECT * FROM linea_traNsACCION
 --select * from linea_traspaso
-- delete from linea_traspaso where Id_Sistema='BFW'
--    rollback transaction
-- delete from linea_traNsACCION --where Id_Sistema='BFW'
-- update linea_traspaso SET NumeroTraspaso=5 where NumeroOperacion=2
 --     --rollback transaction
-- if @@error = 0
--    BEGIN
--    commit transaction
--    SELECT 'BIEN'
--    END
 --      ELSE
--    BEGIN
--    SELECT 'MAL'
-- END
-- GO
--  */
GO
