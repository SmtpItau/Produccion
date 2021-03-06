USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_TRAE_NEMOCLIENTE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTRADAY_TRAE_NEMOCLIENTE]
  (
   @nemo VARCHAR(30)
  )
AS
BEGIN
   SET NOCOUNT ON
   IF LEN(@NEMO) <= 4
   BEGIN
      IF EXISTS(SELECT 1 
               FROM VIEW_CLIENTE a,
                    VIEW_SINACOFI b
               WHERE b.datatec = @nemo
                 AND a.clrut = b.clrut
            )
      BEGIN
         SELECT a.clrut
               ,a.clcodigo
               ,a.clnombre
               ,b.datatec
            FROM VIEW_CLIENTE a,
                 VIEW_SINACOFI b
            WHERE b.datatec = @nemo
              AND a.clrut = b.clrut
      END ELSE BEGIN
         SELECT 'NO EXISTE'
      END
   END ELSE BEGIN
      IF EXISTS(SELECT 1 
               FROM VIEW_CLIENTE a,
                    VIEW_SINACOFI b
               WHERE a.clnombre = @nemo
                 AND a.clrut = b.clrut
            )
      BEGIN
         SELECT a.clrut
               ,a.clcodigo
               ,a.clnombre
               ,b.datatec
            FROM VIEW_CLIENTE a,
                 VIEW_SINACOFI b
            WHERE a.clnombre = @nemo
              AND a.clrut = b.clrut
      END ELSE BEGIN
         SELECT 'NO EXISTE'
      END
   END
   SET NOCOUNT OFF
END

GO
