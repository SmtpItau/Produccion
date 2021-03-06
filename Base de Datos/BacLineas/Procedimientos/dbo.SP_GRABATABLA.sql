USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATABLA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABATABLA    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_GRABATABLA    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_GRABATABLA]( @tbcateg    NUMERIC (   5), 
        @tbcodigo1  CHAR    (   6),
        @tbtasa     NUMERIC (   3),
        @tbfecha    DATETIME      ,
        @tbvalor    NUMERIC (18,6),
        @tbglosa    CHAR    (  50),
        @nemo       CHAR    (  10) 
    )
AS
BEGIN
--    IF EXISTS(SELECT * FROM Tabla_General_Detalle(index=indicemdtc) WHERE tbcateg = @tbcateg AND tbcodigo1 = @tbcodigo1 and tbtasa = @tbtasa and tbfecha = @tbfecha) 
    IF EXISTS(SELECT 1 FROM TABLA_GENERAL_DETALLE WHERE tbcateg = @tbcateg AND tbcodigo1 = @tbcodigo1 and tbtasa = @tbtasa and tbfecha = @tbfecha) 
       UPDATE TABLA_GENERAL_DETALLE        SET  tbtasa  = @tbtasa ,
                      tbfecha = @tbfecha,
          tbvalor = @tbvalor,
            tbglosa = @tbglosa   
                           WHERE tbcateg = @tbcateg and tbcodigo1 = @tbcodigo1 and tbtasa = @tbtasa and tbfecha = @tbfecha
      
    ELSE 
       INSERT INTO TABLA_GENERAL_DETALLE    (tbcateg    , 
       tbcodigo1  ,
       tbtasa     ,
       tbfecha    ,
       tbvalor    ,
       tbglosa    ,
       nemo          
                            ) 
                        VALUES (@tbcateg    , 
           @tbcodigo1  ,
           @tbtasa     ,
           @tbfecha    ,
           @tbvalor    ,
           @tbglosa    ,
    @nemo
        )
END
GO
