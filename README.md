# Podcast App
<img src="https://github.com/Colokol/Movie-Today/assets/122364066/5a75ef86-4670-4f85-8ea5-e8883ef0592f" width="1000">

### Development Team: 
[![Uladzislau Yatskevich](https://img.shields.io/badge/Uladzislau%20Yatskevich-TeamLead-065D8E?style=for-the-badge&logo=github)](https://github.com/Colokol)
[![Anna Zaitsava](https://img.shields.io/badge/Anna%20Zaitsava-06969F?style=for-the-badge&logo=github)](https://github.com/AnnaZaitsava)
[![Nikita Yakovenko](https://img.shields.io/badge/Nikita%20Yakovenko-065D8E?style=for-the-badge&logo=github)](https://github.com/Nikita06122002)
[![Yuri Krasnov](https://img.shields.io/badge/Yuri%20Krasnov-1B91AB?style=for-the-badge&logo=github)](https://github.com/KrasnovYuri)
[![Timofey Spodeneyko](https://img.shields.io/badge/Timofey%20Spodeneyko-06969F?style=for-the-badge&logo=github)](https://github.com/TSpodeneyko)
[![Nikita Semennikov](https://img.shields.io/badge/Nikita%20Semennikov-065D8E?style=for-the-badge&logo=github)](https://github.com/SemennikovNA)

---

**CHALLENGE №3 “Movie for today” [(Swift Marathon X)](https://t.me/devrush_community/13663)**
* Проект на Swift 5, UIKit
* Минимальная поддерживаемая iOS – 15
* Только iPhone и портретная ориентация экрана.
* API: [Kinopoisk API](https://kinopoisk.dev/)
* MVP
* CoreData
* Сторонние библиотеки: SDWebImage
* Тесты

---

<img src="https://github.com/Colokol/Movie-Today/assets/122364066/7dd9499f-f313-4453-a16c-d23f14a3411e" width="1000">

---
# Базовое задание:

**Онбординг**

* Сделать как минимум 3 страницы в онбординге

**Главный экран**

* Сверху экрана аватар, имя и кнопка для перехода в любимые фильмы.
* Search Bar который ищет фильмы по названию.
* Коллекция Movie List. В ней коллекции фильмов.
* Коллекция Popular Movie. Популярные фильмы или лучшие (рейтинг). Можете делать на свой вкус.

**Экран Movie List**

* Показать список фильмов, сделать возможность фильтровать на жанрам.
* Перемотку делать через прогресс бар не нужно в базовом задании.
* При нажатии на ячейку открыть экран как Popular Movie(сверху название листа, далее фильмы).

**Экран Popular Movie**

* Отображаем список популярных фильмов, берите все возможную инфу из API (рейтинг, жанр и т.д.).

**Экран Movie Detail**

* На этом экране показываем полную информацию о фильме.
* В базовом задании кнопка трейлер заглушка.

**Экран Wishlist**

* На этом экране показываем избранные фильмы (попасть можно через home экран).
  
**Экран Search**

* На этом экране идет более подробный поиск (помимо названия фильма - актеры, рейтинг и тд, покопайтесь в апи).
* Ниже коллекцию или 1 фильм который скоро выйдет (Поиск по статусу фильма (пример: "announced", "completed", "!filming").
* Внизу коллекция recent.

**Экран Profile**

* На этом экране показываем данные профиля.
* Notification и Language в базовом задании это заглушки.
* About us - напишите про команду!.
  
---  
# Продвинутое задание*:

**Экран Movie Detail**

* Добавить реализацию для кнопки Trailer (должно открываться видео) + кнопка Share (хотя бы копировать ссылку на видео).
        
**Экран Profile**

* Сделать оповещение на каждый день в стиле - пора смотреть фильмы, время выбирать.
* Сделать смену языка (русский и английский).

**Экран Christmas tree**

* Сделать экран с елочкой, на которой игрушки шарики это кнопки! При нажатии на кнопку появляется рекомендация новогоднего фильма (json наверху прикрепила, можете использовать его или свой).
* Рекомендации не должны повторяться(их 30 штук).
* Сделайте красивую анимацию нажатия на игрушку и появление рекомендации, не обязательно открывать новый экран - плашка с фильмом может просто появляться на заблюренном фоне елки.
* При нажатии на плашку с рекомендацией идет переход на детальный экран с фильмом.
  
---
# Супергеройское задание*:
* Добавить просмотр полноценного фильма (не трейлера).
* В качестве примера можете показать фильм 1+1.

---
