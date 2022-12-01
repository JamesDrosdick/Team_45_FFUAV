function Bdim = Bat_Dimen(B) % B = Battery Selection Struct
B_str = B.Dimensions
B_str_split = split(B_str," x")
B_Length = str2double(B_str_split(1))
B_Width = str2double(B_str_split(2))
B_Height = str2double(B_str_split(3))

Bdim= struct("Bat_Length", B_Length, "Bat_Width", B_Width, "Bat_Height", B_Height)


end 