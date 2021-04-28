unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  f: TextFile;
  str,word,xword: string;
  i,j,n,k,count,x: integer;
  letter,buf: char;
implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Memo1Change(Sender: TObject);
begin
  if (Memo1.GetTextLen() > 0) then begin
    Button1.Enabled := true;    
    Button3.Enabled := true;
    //StatusBar1.Panels[0].Text := 'Okay';
  end else begin
    Button1.Enabled := false;
    Button3.Enabled := false;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (saveDialog1.Execute) then begin
    assignFile(f,saveDialog1.fileName);
    StatusBar1.Panels[0].Text := saveDialog1.fileName;
    reWrite(f);
    Memo1.Lines.SaveToFile(saveDialog1.fileName);
    closeFile(f);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (openDialog1.Execute) then begin
    assignFile(f,openDialog1.fileName);
    StatusBar1.Panels[0].Text := openDialog1.fileName;
    reSet(f); 
    Memo1.Lines.LoadFromFile(openDialog1.fileName);
    closeFile(f);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  str := Memo1.Text+' ';
  str := StringReplace(str, #10, ' ', [rfReplaceAll]);
  i:=1;

  //while i <= Length(str) do begin
  //    if (str[i]=' ') then begin
  //      if(str[i+1]=' ') then delete(str, i+1,1);
  //      i:=0;
  //    end;
  //    i:=i+1;
  //end;
  //       
  //Edit1.Text := str;

  n:=0;
  k:=0;
  Memo1.Clear;

  for i:=1 to Length(str) do begin
      if (str[i]=' ') then begin
        k:=i;
        word := Copy(str, n+1, k-n-1);
        Memo1.Lines.Add(word); //debug
        buf:=word[1]; count:=1; x:=0; j:=1;

        while j < length(word)-1 do begin
            if (letter=word[j+1]) then begin
              letter:=word[j+1];
              count:=count+1;
            end else begin
              letter:=word[j+1];
              x:=count;
              count:=1;
            end;
            if (count > x) then begin
              xword:=word;
            end;
            j:=j+1;
        end;

        n:=i;
      end;
  end;  
  Edit1.Text := intToStr(x);
  Memo2.Lines.Add(xword);
end;

end.

