CREATE TABLE [dbo].[SIC_sys_MenuListCatelog] (
    [ids]         INT          IDENTITY (1, 1) NOT NULL,
    [Area]        VARCHAR (50) NULL,
    [category]    VARCHAR (50) NULL,
    [orderby]     INT          NULL,
    [Image]       VARCHAR (20) NULL,
    [lu_date]     DATETIME     NULL,
    [lu_function] VARCHAR (50) NULL,
    [lu_user]     VARCHAR (50) NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_MenuListCatelog_index]
    ON [dbo].[SIC_sys_MenuListCatelog]([Area] ASC, [category] ASC, [orderby] ASC);

