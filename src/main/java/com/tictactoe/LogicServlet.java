package com.tictactoe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/logic")
public class LogicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        int index = getIndex(req);

        Field field = extractField(session);

        if (field.getField().get(index) == Sign.EMPTY) {
            field.getField().put(index, Sign.CROSS);
            if (checkWin(resp, session, field)) {
                return;
            }



            int emptyFieldIndex = field.getEmptyFieldIndex();
            if (emptyFieldIndex >= 0) {
                field.getField().put(emptyFieldIndex, Sign.NOUGHT);
                if (checkWin(resp, session, field)) {
                    return;
                }
            }else{
                session.setAttribute("draw", true);
            }
            List<Sign> data = field.getFieldData();

            session.setAttribute("field", field);
            session.setAttribute("data", data);
        }

        resp.sendRedirect("/index.jsp");


    }

    private int getIndex(HttpServletRequest req) {
        String click = req.getParameter("click");
        try {
            return Integer.parseInt(click);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    private Field extractField(HttpSession session) {
        Object field = session.getAttribute("field");
        if (field.getClass() != Field.class) {
            session.invalidate();
            throw new RuntimeException();
        }
        return (Field) field;
    }

    private boolean checkWin(HttpServletResponse resp, HttpSession session, Field field) throws IOException {
        Sign sign = field.checkWin();
        if (Sign.CROSS == sign || Sign.NOUGHT == sign) {
            session.setAttribute("winner", sign);

            List<Sign> data = field.getFieldData();

            session.setAttribute("data", data);
            resp.sendRedirect("/index.jsp");
            return true;
        }
        return false;
    }
}
