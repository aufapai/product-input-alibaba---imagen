with open('App/template.html', encoding='utf-8') as f:
    text = f.read()
import re
print('toastBox matches:', [m.start() for m in re.finditer(r'toastBox', text)])
print('toastMsg matches:', [m.start() for m in re.finditer(r'toastMsg', text)])
for m in re.finditer(r'id=[\"\']toast', text):
    print(text[m.start():m.start()+50])

